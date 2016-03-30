#!/usr/bin/env python
# -*- coding: utf-8 -*-

from Loader import *
import json

for post in RawDatabase.find(
    {'fetched': {'$ne': True}}
):
    print (post['version'][-1]['title'].encode('utf-8'))
    JobClient.submit_job(
        'dcard-scrap-post',
        json.dumps({
            'board': post['forum_alias'],
            'article': post['id']
        }).encode('utf-8'),
        background=True,
        priority=gearman.PRIORITY_HIGH,
        unique=str(post['id'])
    )
