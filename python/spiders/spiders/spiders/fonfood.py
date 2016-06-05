# -*- coding: utf-8 -*-
import __future__
import sys
from os import path
sys.path.append(path.dirname(path.dirname(path.dirname(path.dirname(path.abspath(__file__))))))
# print sys.path

import scrapy
from scrapy.conf import settings
from scrapy.spiders import CrawlSpider, Rule
from scrapy.linkextractors import LinkExtractor
from bson.binary import Binary
import Database
import Commons
import urllib
import pprint
import uniout
import random
import time
import json
import re


class FonfoodSpider(CrawlSpider):

    # settings.set('LOG_LEVEL', 'DEBUG')  # WARNING
    settings.set('DOWNLOAD_DELAY', 0)

    name = "fonfood"
    allowed_domains = ["www.fonfood.com"]
    start_urls = (
        'http://www.fonfood.com',
    )

    Collection = Database.Mongo['fonfood']

    links_db = Collection['stores']
    index_db = Collection['links']

    rules = (
        Rule(LinkExtractor(allow=('\/基隆市|台北市|新北市|桃園市|新竹市|新竹縣|苗栗縣|台中市|南投縣|彰化縣|雲林縣|嘉義市|嘉義縣|台南市|高雄市|屏東縣|宜蘭縣|花蓮縣|台東縣|澎湖縣|金門縣|連江縣\/?\d*', )), callback='show_1', follow=True),
        Rule(LinkExtractor(allow=('\/store\/\d+$', )), callback='parse_article', follow=True),
    )

    telRegex = re.compile(ur'([^\d])', re.MULTILINE)

    def show_1(self, response):
        self.index_db.update_one(
            {'link': response.url},
            {
                '$set': {
                    'link': response.url,
                    'hash': Commons.make_sha1(response.url.encode('utf-8'))
                }
            }, upsert=True
        )
        print(response.url)

    def parse_article(self, response):

        store = {}.copy()

        article = response.css('div[itemtype="http://data-vocabulary.org/Organization"]')

        store['link'] = response.url

        store['name'] = article.css('span[itemprop="name"]::text').extract_first()

        if store['name']:

            store['hash'] = Commons.make_sha1(store['link'].encode('utf-8'))

            store['telephone'] = article.css('span[itemprop="tel"]::text').extract_first()
            if store['telephone']:
                store['telephone'] = re.sub(self.telRegex, '', store['telephone'])

            store['description'] = response.css('meta[name="description"]::attr("content")').extract_first()

            store['locality'] = article.css('span[itemprop="region"]::text').extract_first()
            store['region'] = article.css('span[itemprop="locality"]::text').extract_first()

            store['streetAddress'] = article.css('span[itemprop="street-address"]::text').extract_first()

            store['address'] = ''

            if store['locality']:
                store['address'] += store['locality']

            if store['region']:
                store['address'] += store['region']

            if store['streetAddress']:
                store['address'] += store['streetAddress']

            store['latitude'] = article.css('meta[itemprop="latitude"]::attr("content")').extract_first()
            store['longitude'] = article.css('meta[itemprop="longitude"]::attr("content")').extract_first()

            store['officialSite'] = article.css('span[itemprop="url"]::text').extract_first()

            store['image'] = response.css('div.infoImage img::attr("src")').extract_first()
            if store['image']:
                img_res = urllib.urlopen(store['image']).read()
                if img_res:
                    store['image'] = Binary(img_res)

            store['breadcrumb'] = []

            for td in response.css('div#store div.infoBasic table tr'):
                if u'類別：' == td.css('tr td:nth-child(1) h2::text').extract_first():
                    for a in td.css('tr td:nth-child(2) a'):
                        cat = a.css('a::text').extract_first()
                        if cat:
                            store['breadcrumb'].append(cat)

            self.links_db.update_one(
                {'link': store['link']},
                {
                    '$set': store
                }, upsert=True
            )

            print('saved', store['name'].encode('utf-8'))
        else:
            print('skipped', response.url)
        #
        # time.sleep(random.randrange(3, 5))
