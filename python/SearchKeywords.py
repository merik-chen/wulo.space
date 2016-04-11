#!/usr/bin/env python
# -*- coding: utf-8 -*-
from scrapy import Selector
import Database
import urlparse
import requests
import Commons
import random
import json
import time
import re

RedisKey = 'QueuedKeywords'
RedisKeyOT = RedisKey + ':OT'
RedisKeyContainer = RedisKey + ':Data'


def fetch_desktop_index():
    rst = []
    url = u'https://tw.yahoo.com'
    r = requests.get(url, headers = {'user-agent': 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_10_5) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/43.0.2357.134 Safari/537.36'})
    if r.status_code == 200 :
        response = Selector(text=r.text.encode('utf-8', 'ignore'))
        info = response.xpath("//html/body/div[@id='MasterWrap']/div/div/div[@data-region='main']/div/div/div[@id='uhWrapper']/table/tbody/tr/td[2]/form/table/tbody/tr[2]/td/ul/li/a/@href").extract()
        for url in info:
            temp = dict(urlparse.parse_qsl(urlparse.urlparse(url).query.encode('utf-8')))
            rst.append(temp[u'p'])
    return rst


def fetch_desktop_search_index():
    rst = []
    url = u'https://tw.search.yahoo.com/search?p=%E7%86%B1%E9%96%80%E6%90%9C%E5%B0%8B'
    r = requests.get(url, headers = {'user-agent': 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_10_5) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/43.0.2357.134 Safari/537.36'})
    if r.status_code == 200 :
        response = Selector(text=r.text.encode('utf-8', 'ignore'))
        info = response.css("div#right ol.searchRightBottom div.compList li a::attr('href')").extract()
        for url in info:
            temp = dict(urlparse.parse_qsl(urlparse.urlparse(url).query.encode('utf-8')))
            rst.append(temp[u'p'])
    return rst


def fetch_mobile_index():
    rst = []
    url = u'https://tw.mobi.yahoo.com/_td/api/resource/TrendingService;treningNowUrl=http%3A%2F%2Ftw.kvc.search.yahoo.com%3A4080%2Fkv%2Fget%3Fformat%3Djson%26type%3Dmetro%26src%3Dmetro%26order%3Drank%26count%3D8%26ns%3Dzh_tw%26appid%3Dtn_uh_tw%26key%3Dtn_general_uni;update=true?bkt=&device=smartphone&intl=tw&lang=zh-Hant-TW&partner=none&region=TW&site=fp&tz=Asia%2FTaipei&ver=1.1.161&returnMeta=true'
    r = requests.get(url, headers={'user-agent': 'Mozilla/5.0 (BB10; Touch) AppleWebKit/537.10+ (KHTML, like Gecko) Version/10.0.9.2372 Mobile Safari/537.10+'})
    if r.status_code == 200:
        response = json.loads(json.loads(r.text.encode('utf-8', 'ignore')))
        for index, keyword in response.items():
            if index != u'title':
                temp = dict(urlparse.parse_qsl(urlparse.urlparse(keyword[u'link']).query.encode('utf-8')))
                rst.append(temp[u'p'])
    return rst


def fetch():
    keywords = {}
    result = {
        'Desktop': fetch_desktop_index(),
        'Search': fetch_desktop_search_index(),
        'Mobile': fetch_mobile_index()
    }.copy()

    for index, rst in result.iteritems():
        for source in rst:
            keywords[source] = source

    for keyword in keywords:
        if not Database.Redis.zscore(RedisKey, keyword):
            Database.Redis.zadd(RedisKey, keyword, 1)
        if not Database.Redis.zscore(RedisKeyOT, keyword):
            Database.Redis.zadd(RedisKeyOT, keyword, 1)

    r = requests.post(
        'https://www.google.com.tw/trends/hottrends/hotItems',
        headers={'user-agent': 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_10_5) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/43.0.2357.134 Safari/537.36'},
        data={
            'ajax': 1,
            'htv': 'l',
            'pn': 'p12'
        }
    )

    if r.status_code == 200:
        response = json.loads(r.text.encode('utf-8', 'ignore'))
        for kw in response['trendsByDateList'][0]['trendsList']:
            if not Database.Redis.zscore(RedisKey, kw['title']):
                Database.Redis.zadd(RedisKey, kw['title'], 1)
            if not Database.Redis.zscore(RedisKeyOT, kw['title']):
                Database.Redis.zadd(RedisKeyOT, kw['title'], 1)

if __name__ == "__main__":
    fetch()
