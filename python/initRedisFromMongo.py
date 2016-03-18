#!/usr/bin/env python
# -*- coding: utf-8 -*-

import Database
import Commons
import json
import time
import re

filter_regex = re.compile(ur'ptt.+/bbs/(?P<b>\w+)/(?P<a>[\w\.]+)\.html?')
all = Database.Database.find({"title": {"$exists": True}}, {
    'article': 1,
    'board': 1,
    'title': 1,
    'url': 1,
})

for post in all:
    print post['title']

    if ('board' not in post) or ('article' not in post):
        find = re.search(filter_regex, post['url'])
        if find:
            post['board'] = find.groupdict()['b']
            post['article'] = find.groupdict()['a']

    if 'wulo' in post:
        # board <-> user relations
        Database.Redis.zincrby(
            'bd:' + post['board'].encode('utf-8'),
            'ur:' + post['wulo']['user'].encode('utf-8'),
            1
        )

        # user <-> board relations
        Database.Redis.zincrby(
            'ur:' + post['wulo']['user'].encode('utf-8'),
            'bd:' + post['board'].encode('utf-8'),
            1
        )

    # board <-> articles
    Database.Redis.sadd(
        post['board'].encode('utf-8'),
        post['article'].encode('utf-8'),
    )
