#!/usr/bin/env python
# -*- coding: utf-8 -*-

from Loader import *
import traceback
import requests
import Utility


class Comment:

    utility = Utility.Utility()
    INITIAL_ENDPOINT = 'https://www.dcard.tw/f'
    USER_AGENT = random_ua()
    COOKIE_XSRF = None

    POST_ENDPOINT_PREFIX = 'https://www.dcard.tw/_api/posts/%s/comments?after=%s'
    POST_ENDPOINT_HEADER = {
        'referer': 'https://www.dcard.tw/f',
        'X-Csrf-Token': COOKIE_XSRF,
        'X-Requested-With': 'XMLHttpRequest'
    }

    start_count = 0
    article_id = ''

    result = []

    def __init__(self, article_id=None):
        self.article_id = article_id and article_id or None

    def get_comments(self, article_id):
        self.article_id = article_id and article_id or self.article_id

        self.start_count = 0
        isContinue = True

        if (self.article_id is None) or (len(str(self.article_id)) == 0):
            raise ValueError('Article ID is empty')

        if self.COOKIE_XSRF is None:
            self.COOKIE_XSRF = self.utility.initial_connect()

        while isContinue:
            isContinue = False

            r = requests.get(
                self.POST_ENDPOINT_PREFIX % (self.article_id, self.start_count),
                headers=self.POST_ENDPOINT_HEADER
            )

            if r.status_code == 200:
                self.COOKIE_XSRF = self.utility.parse_xsrf_token(r.headers)
                self.start_count += len(r.json())
                for comment in r.json():
                    self.result.append(comment)
                    isContinue = isContinue or True
            else:
                raise InputError('Can not get comments.', None)

        return self.result

if '__main__' == __name__:
    import pprint
    comment = Comment()
    pprint.pprint(comment.get_comments('224113984'))

