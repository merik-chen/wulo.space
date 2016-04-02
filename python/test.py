#!/usr/bin/env python
# -*- coding: utf-8 -*-

import Database
import pprint
import json

# post = Article()
# https://www.ptt.cc/bbs/LGBT_SEX/M.1420384076.A.818.html
# pprint.pprint(post.get_article('LGBT_SEX', 'M.1456717141.A.C4D'))
# data, raw = post.get_article('LGBT_SEX', 'M.1456717141.A.C4D', with_raw=True)
#
# pprint.pprint(data)

# ticket = Database.JobClient.submit_job(
#     'wulo-get-ptt-article',
#     json.dumps({
#         'board': 'StupidClown',
#         'article': 'M.1457268374.A.827'
#     }),
#     background=True
# )
#
# pprint.pprint(ticket)

# runing = True
#
# while runing:
#     var = raw_input("Please enter userID: ")
#     if len(var) > 0:
#         Database.Database.delete_one({'hash': '%s' % var})
#     else:
#         runing = False

table = {}

for info in Database.RawDatabase.find({}, {'hash': 1}):
    if info['hash'] in table:
        table[info['hash']] += 1
    else:
        table[info['hash']] = 1

for key, value in table.items():
    if value > 1:
        print key, value
        for times in xrange(value - 1):
            Database.RawDatabase.delete_one({'hash': '%s' % key})
