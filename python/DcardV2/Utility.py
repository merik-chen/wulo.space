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

    def parse_xsrf_token(self, raw_headers):
        if 'X-Csrf-Token' in raw_headers:
            self.COOKIE_XSRF = raw_headers['X-Csrf-Token']
            return self.COOKIE_XSRF
        else:
            return None

    def initial_connect(self):
        r = requests.get(
            self.INITIAL_ENDPOINT,
            headers={
                'user-agent': random_ua()
            }
        )

        if r.status_code == 200:
            csrf_token_regex = re.compile('"csrfToken":"([\w\-_]+)"')
            find = re.findall(csrf_token_regex, r.content)
            if find:
                self.COOKIE_XSRF = find[0]
                return self.COOKIE_XSRF
            else:
                raise Exception('Can not get CSRF Token.')
        else:
            raise Exception('Initial connection failed.')
