#!/usr/bin/env python
# -*- coding: utf-8 -*-

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

for post in PttDB.find():
    AccountDB.find_one_and_update(
        {'id': post['author']},
        {
            '$set': {
                'id': post['author'],
                'associate.ptt': True
            }
        }, upsert=True
    )
