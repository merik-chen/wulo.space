#!/usr/bin/env python
# -*- coding: utf-8 -*-

from Loader import *
import traceback
import requests
import random
import Cookie
import time

INITIAL_ENDPOINT = 'https://www.dcard.tw/f'
USER_AGENT = random_ua()
COOKIE = Cookie.SimpleCookie()
COOKIE_XSRF = ''

LIST_ENDPOINT_PREFIX = 'https://www.dcard.tw/api/forum/all/%s/'
LIST_ENDPOINT_HEADER = {
    'referer': 'https://www.dcard.tw/f',
    'x-xsrf-token': COOKIE_XSRF
}

INITIAL_PAGE = 1


def parse_xsrf_token(raw_cookie):
    global COOKIE, COOKIE_XSRF
    COOKIE.load(raw_cookie.encode('utf-8'))
    COOKIE_XSRF = COOKIE['XSRF-TOKEN'].value
    return COOKIE_XSRF


def initial_connect():
    global COOKIE, USER_AGENT, INITIAL_ENDPOINT, COOKIE_XSRF
    r = requests.get(
        INITIAL_ENDPOINT,
        headers={
            'user-agent': USER_AGENT
        }
    )

    if r.status_code == 200:
        parse_xsrf_token(r.headers['set-cookie'])
    else:
        print 'Initial connection failed.'
        exit()


def scrap_list(page):
    global COOKIE, USER_AGENT, COOKIE_XSRF, LIST_ENDPOINT_HEADER, LIST_ENDPOINT_PREFIX
    r = requests.get(
        LIST_ENDPOINT_PREFIX % page.encode('utf-8'),
        headers=LIST_ENDPOINT_HEADER
    )

    if r.status_code == 200:
        parse_xsrf_token(r.headers['set-cookie'])
        return r.json()

if '__main__' == __name__:
    initial_connect()
    isContinue = True
    while isContinue:
        try:
            isContinue = False
            random_sleep = random.randrange(5, 30)
            USER_AGENT = random_ua()
            for index, data in enumerate(scrap_list(str(INITIAL_PAGE))):
                if RawDatabase.find_one({'id': data['id']}) is None:
                    isContinue = True or isContinue
                    RawDatabase.save(data)
            print 'Scraped Dcard page %s.\tSleep %s sec(s).' % (INITIAL_PAGE, random_sleep)
            time.sleep(random_sleep)
            INITIAL_PAGE += 1
        except KeyboardInterrupt:
            print "\nBye"
            sys.exit()
        except 'Exception' as e:
            traceback.print_exc()
            sys.exit()

    print "No more update, Bye~\n"
    sys.exit()
