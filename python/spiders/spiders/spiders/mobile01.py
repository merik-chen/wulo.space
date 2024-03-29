# -*- coding: utf-8 -*-
import sys
from os import path
sys.path.append(path.dirname(path.dirname(path.dirname(path.dirname(path.abspath(__file__))))))
# print sys.path

import scrapy
from scrapy.spiders import CrawlSpider, Rule
from scrapy.linkextractors import LinkExtractor
import Database
import Commons
import random
import time
import json
import re


class Mobile01Spider(CrawlSpider):
    name = "mobile01"
    allowed_domains = ["mobile01.com"]
    start_urls = (
        'http://www.mobile01.com/forum.php',
    )

    collection = Database.Mongo[name]
    links_db = collection['links']
    index_db = collection['index']

    rules = (
        Rule(LinkExtractor(allow=('category', )), callback='show_1', follow=True),
        Rule(LinkExtractor(allow=('\/bbs\/[0-9a-zA-Z\.-_]+\/index[0-9]{0,4}\.html', )), callback='show_1', follow=True),
        Rule(LinkExtractor(allow=('\/bbs\/[0-9a-zA-Z\.-_]+\/M\..+\.html$', )), callback='parse_article', follow=True),
    )

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
        print response.url

    def parse_article(self, response):
        filter_regex = re.compile(ur'ptt.+/bbs/(?P<b>\w+)/(?P<a>[\w\.]+)\.html?')
        if self.links_db.find_one({'link': response.url}) is None:
            find = re.search(filter_regex, response.url)
            if find:
                info = find.groupdict()

                Database.JobClient.submit_job(
                    'wulo-get-ptt-article',
                    json.dumps({
                        'board': info['b'],
                        'article': info['a']
                    }),
                    background=True
                )

            self.links_db.update_one(
                {'link': response.url},
                {
                    '$set': {
                        'link': response.url,
                        # 'title': response.title
                    }
                }, upsert=True
            )

            print 'saved', response.url

        time.sleep(random.randrange(1, 2))
