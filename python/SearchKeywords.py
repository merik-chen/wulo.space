#!/usr/bin/env python
# -*- coding: utf-8 -*-

import Database
import requests
import Commons
import random
import json
import time
import re

RedisKey = 'QueuedKeywords'
RedisKeyOT = RedisKey + ':OT'
RedisKeyContainer = RedisKey + ':Data'


def fetch():

    # time.sleep(random.randrange(0, 3540))

    # find_time = int(time.time())

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
