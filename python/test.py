#!/usr/bin/env python
# -*- coding: utf-8 -*-

from Ptt.Article import Article
import Database
import pprint

post = Article()
# https://www.ptt.cc/bbs/LGBT_SEX/M.1420384076.A.818.html
# pprint.pprint(post.get_article('LGBT_SEX', 'M.1456717141.A.C4D'))
data, raw = post.get_article('LGBT_SEX', 'M.1456717141.A.C4D', with_raw=True)

pprint.pprint(data)
