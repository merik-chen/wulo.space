#!/usr/bin/env python
# -*- coding: utf-8 -*-

from Loader import *
import requests
import Utility


class Article:

    utility = Utility.Utility()
    INITIAL_ENDPOINT = 'https://www.dcard.tw/f'
    USER_AGENT = random_ua()
    COOKIE_XSRF = None

    POST_ENDPOINT_PREFIX = 'https://www.dcard.tw/api/post/%s/%s/'
    POST_ENDPOINT_HEADER = {
        'referer': 'https://www.dcard.tw/f',
        'x-xsrf-token': COOKIE_XSRF,
        'X-Requested-With': 'XMLHttpRequest'
    }

    board = ''
    article_id = ''

    def __init__(self, board=None, article_id=None):
        self.board = board and board or None
        self.article_id = article_id and article_id or None

    def get_article(self, board, article_id):
        self.board = board and board or self.board
        self.article_id = article_id and article_id or self.article_id

        if (self.board is None) or (len(self.board) == 0):
            raise ValueError('Board is empty')

        if (self.article_id is None) or (len(str(self.article_id)) == 0):
            raise ValueError('Article ID is empty')

        if self.COOKIE_XSRF is None:
            self.COOKIE_XSRF = self.utility.initial_connect()

        r = requests.get(
            self.POST_ENDPOINT_PREFIX % (self.board, self.article_id),
            headers=self.POST_ENDPOINT_HEADER
        )

        if r.status_code == 200:
            self.utility.parse_xsrf_token(r.headers['set-cookie'])
            return r.json()
        else:
            raise InputError('Can not get the article.')


if '__main__' == __name__:
    import pprint
    article = Article()
    pprint.pprint(article.get_article('funny', '46939040'))

