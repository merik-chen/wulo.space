#!/usr/bin/env python
# -*- coding: utf-8 -*-

import Database
import Commons
import json
import time
import re

filter_regex = re.compile(ur'ptt.+/bbs/(?P<b>\w+)/(?P<a>[\w\.]+)\.html?')
all = Database.Database.find({"title": {"$exists": True}}, {
    'title': 1,
    'hash': 1,
    'url': 1,
})

for post in all:
    print (post['title'].encode('utf-8')),

    find = Database.Mongo['screenshot']['store'].find_one({'hash': post['hash']})

    if find:
        Database.JobClient.submit_job(
            'scrap-screenshot',
            json.dumps({
                'url': post['url']
            }),
            unique=post['hash'],
            background=True
        )
        print ('queued.')
    else:
        print ('skipped')

