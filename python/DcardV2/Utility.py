#!/usr/bin/env python
# -*- coding: utf-8 -*-

from Loader import *
import Cookie


class Utility:

    INITIAL_ENDPOINT = 'https://www.dcard.tw/f'
    USER_AGENT = random_ua()
    COOKIE = Cookie.SimpleCookie()
    COOKIE_XSRF = ''

    def __init__(self):
        pass

    def parse_xsrf_token(self, raw_cookie):
        self.COOKIE.load(raw_cookie.encode('utf-8'))
        self.COOKIE_XSRF = self.COOKIE['XSRF-TOKEN'].value
        return self.COOKIE_XSRF

    def initial_connect(self):
        r = requests.get(
            self.INITIAL_ENDPOINT,
            headers={
                'user-agent': random_ua()
            }
        )

        if r.status_code == 200:
            return self.parse_xsrf_token(r.headers['set-cookie'])
        else:
            raise Exception('Initial connection failed.')
