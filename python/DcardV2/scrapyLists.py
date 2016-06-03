#!/usr/bin/env python
# -*- coding: utf-8 -*-

from __future__ import print_function
from Loader import *
from pprint import pprint
import SimpleGearManAdmin
import traceback
import requests
import random
import Cookie
import time
import json
import re

INITIAL_ENDPOINT = 'https://www.dcard.tw/f'
INITIAL_BOARD_LIST_ENDPOINT = 'https://www.dcard.tw/_api/forums'
USER_AGENT = random_ua()
COOKIE = Cookie.SimpleCookie()
COOKIE_XSRF = ''
BOARDS = {}
NOW_BOARD = ''

LIST_ENDPOINT_PREFIX = 'https://www.dcard.tw/_api/forums/%s/posts%s'
LIST_POPULAR_ENDPOINT_PREFIX = 'https://www.dcard.tw/_api/forums/%s/posts?popular=true&before=%s'
LIST_ENDPOINT_HEADER = {
    'referer': 'https://www.dcard.tw/f',
    'X-Csrf-Token': COOKIE_XSRF
}

INITIAL_PAGE = ''


def parse_xsrf_token(raw_headers):
    global COOKIE, COOKIE_XSRF
    if 'X-Csrf-Token' in raw_headers:
        COOKIE_XSRF = raw_headers['X-Csrf-Token']
        return COOKIE_XSRF
    else:
        return None


def initial_connect():
    global COOKIE, USER_AGENT, INITIAL_ENDPOINT, COOKIE_XSRF
    r = requests.get(
        INITIAL_ENDPOINT,
        headers={
            'user-agent': USER_AGENT
        }
    )

    if r.status_code == 200:
        csrf_token_regex = re.compile('"csrfToken":"([\w\-_]+)"')
        find = re.findall(csrf_token_regex, r.content)
        if find:
            COOKIE_XSRF = find[0]
            return COOKIE_XSRF
    else:
        print('Initial connection failed.')
        exit()


def get_board_list():
    global COOKIE, USER_AGENT, INITIAL_BOARD_LIST_ENDPOINT, COOKIE_XSRF, LIST_ENDPOINT_HEADER
    r = requests.get(
        INITIAL_BOARD_LIST_ENDPOINT,
        headers=LIST_ENDPOINT_HEADER
    )

    if r.status_code == 200:
        parse_xsrf_token(r.headers)
        boards = r.json()
        for board in boards:
            BoardsDatabase.update_one(
                {'alias': board['alias']},
                {'$set': board},
                upsert=True
            )
            JobClient.submit_job(
                'dcard-v2-scarp-board',
                board['alias'].encode('utf-8'),
                background=True,
                unique=board['alias'].encode('utf-8')
            )
    else:
        print('Initial connection failed.')
        exit()


def scrap_list(page):
    global COOKIE, USER_AGENT, COOKIE_XSRF, LIST_ENDPOINT_HEADER, LIST_ENDPOINT_PREFIX, NOW_BOARD
    r = requests.get(
        LIST_ENDPOINT_PREFIX % (NOW_BOARD.encode('utf-8'), len(page) > 0 and '?before=%s' % page or ''),
        headers=LIST_ENDPOINT_HEADER
    )

    if r.status_code == 200:
        parse_xsrf_token(r.headers)
        return r.json()


def dcard_scarp_board(gearman_worker, gearman_job):
    global USER_AGENT, INITIAL_PAGE, NOW_BOARD
    NOW_BOARD = gearman_job.data
    initial_connect()
    is_continue = True
    INITIAL_PAGE = ''
    while is_continue:
        try:
            is_continue = False
            random_sleep = random.randrange(5, 30)
            USER_AGENT = random_ua()
            for index, data in enumerate(scrap_list(str(INITIAL_PAGE))):
                if RawDatabase.find_one({'id': data['id']}) is None:
                    is_continue = True or is_continue
                    INITIAL_PAGE = data['id']
                    RawDatabase.save(data)
            print('Dcard: Scraped %s page %s.\tSleep %s sec(s).' % (
                NOW_BOARD.encode('utf-8'),
                INITIAL_PAGE,
                random_sleep
            ))
            time.sleep(random_sleep)

            if is_continue:
                pass
            else:
                print("This Board: %s scraped. Do next.\n" % NOW_BOARD.encode('utf-8'))
                print("Checking board remains in pool...\t")
                _board_remain = SimpleGearManAdmin.SimpleGearManAdmin(
                    app_cfg['gearman']['address'],
                    app_cfg['gearman']['port']
                ).get_status('dcard-v2-scarp-board')
                if (_board_remain is None) or (int(_board_remain['queued']) <= (int(_board_remain['workers']) + 1)):
                    get_board_list()
                    print("Re-Filling.\n")
                else:
                    print("Enough.\n")

        except 'Exception' as e:
            traceback.print_exc()
            sys.exit()

    print('Sleep for 5 minutes.\n')
    time.sleep(5 * 60)

    return 'ok'

if '__main__' == __name__:
    print(app_env)

    try:
        board_remain = SimpleGearManAdmin.SimpleGearManAdmin(
            app_cfg['gearman']['address'],
            app_cfg['gearman']['port']
        ).get_status('dcard-v2-scarp-board')

        print(board_remain)
        if (board_remain is None) or (int(board_remain['queued']) == 0):
            print('Re-Fill boards...\t')
            initial_connect()
            get_board_list()
            print('done.\n')

        print('Start Worker...\t')
        JobWorker.register_task('dcard-v2-scarp-board', dcard_scarp_board)
        JobWorker.work()
        print('done.\n')

    except KeyboardInterrupt:
        print("\nBye")
        sys.exit()
    except 'Exception' as e:
        traceback.print_exc()
        sys.exit()

    # initial_connect()
    # BOARDS = get_board_list()['forum']
    # NOW_BOARD = BOARDS.pop(0)
    #
    # isContinue = True
    # while isContinue:
    #     try:
    #         isContinue = False
    #         random_sleep = random.randrange(5, 30)
    #         USER_AGENT = random_ua()
    #         for index, data in enumerate(scrap_list(str(INITIAL_PAGE))):
    #             if RawDatabase.find_one({'id': data['id']}) is None:
    #                 isContinue = True or isContinue
    #                 RawDatabase.save(data)
    #         print 'Dcard: Scraped %s page %s.\tSleep %s sec(s).' % (
    #             NOW_BOARD['alias'].encode('utf-8'),
    #             INITIAL_PAGE,
    #             random_sleep
    #         )
    #         time.sleep(random_sleep)
    #
    #         if isContinue:
    #             INITIAL_PAGE += 1
    #         else:
    #             if len(BOARDS) > 0:
    #                 print "This Board: %s scraped. Do next.\n" % NOW_BOARD['alias'].encode('utf-8')
    #                 NOW_BOARD = BOARDS.pop(0)
    #                 INITIAL_PAGE = 1
    #                 isContinue = True
    #
    #     except KeyboardInterrupt:
    #         print "\nBye"
    #         sys.exit()
    #     except 'Exception' as e:
    #         traceback.print_exc()
    #         sys.exit()
    #
    # print "No more update, Bye~\n"
    # sys.exit()
