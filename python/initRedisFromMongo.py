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
    'wulo': 1,
    'url': 1,
}, no_cursor_timeout=True)

counter = 0

for post in all:
    # print post['title'].encode('utf-8')

    if (counter % 1000) == 0:
        print ('Now %s processed.' % counter)

    if ('board' not in post) or ('article' not in post):
        find = re.search(filter_regex, post['url'])
        if find:
            post['board'] = find.groupdict()['b']
            post['article'] = find.groupdict()['a']

    if 'title' in post:
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
        Database.Redis.rpush(
            post['board'].encode('utf-8'),
            post['article'].encode('utf-8'),
        )

        # global <-> articles
        Database.Redis.hset(
            'allArticlesList',
            post['article'].encode('utf-8'),
            post['board'].encode('utf-8')
        )
        # global <-> boards
        Database.Redis.zincrby(
            'allBoardsList',
            post['board'].encode('utf-8'),
            1
        )

        # global <-> articles
        Database.Redis.sadd(
            'allArticlesSets',
            json.dumps({
                'board': post['board'].encode('utf-8'),
                'article': post['article'].encode('utf-8')
            }),
        )
        # global <-> boards
        Database.Redis.sadd(
            'allBoardsSets',
            post['board'].encode('utf-8'),
        )

    counter += 1
