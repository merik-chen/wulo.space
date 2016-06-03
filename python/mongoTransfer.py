#!/usr/bin/env python
# -*- coding: utf-8 -*-

import pymongo

mongo_source = pymongo.MongoClient('122.117.230.71')
mongo_target = pymongo.MongoClient('127.0.0.1')

for data in mongo_source['wulo']['data'].find(no_cursor_timeout=True):
    rsp = mongo_target['wulo']['data'].update_one(
        {'_id': data['_id']},
        {
            '$set': data
        },
        upsert=True
    )

    print("%s is %s." % (
        str(data['_id']),
        rsp.matched_count and 'updated' or 'inserted'
    ))



