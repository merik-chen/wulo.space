#!/usr/bin/env python
# -*- coding: utf-8 -*-

from scrapy import Selector
from Exceptions.InputError import InputError
import traceback
import Database
import requests
import random
import json
import time

AccountDB = Database.Mongo['account']['id_table']
DcardDB = Database.Mongo['Dcard']['raw_posts']
PttDB = Database.Mongo['wulo']['data']

for post in Database.Mongo['wulo']['raw'].find():
    selector = Selector(text=post['html'])
    for user in selector.css('.push-userid::text').extract():

        find = AccountDB.find_one({'id': user}, {'_id': 1})

        if find is None:
            AccountDB.find_one_and_update(
                {'id': user},
                {
                    '$set': {
                        'id': user,
                        'associate.ptt': user
                    }
                }, upsert=True
            )
        else:
            print (user, str(find['_id']))

# for post in PttDB.find():
#     if 'author' in post:
#         nick = 'nick' in post and post['nick'] or post['author']
#         AccountDB.find_one_and_update(
#             {'id': post['author']},
#             {
#                 '$set': {
#                     'id': post['author'],
#                     'associate.ptt': post['nick']
#                 }
#             }, upsert=True
#         )
