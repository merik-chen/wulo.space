#!/usr/bin/env python
# -*- coding: utf-8 -*-

from Loader import *
import json

for post in RawDatabase.find(
    {'fetched': {'$ne': True}}
):
    print (post['title'].encode('utf-8'))
    JobClient.submit_job(
        'dcard-v2-scrap-post',
        str(post['id']),
        background=True,
        priority=gearman.PRIORITY_HIGH,
        unique=str(post['id'])
    )
