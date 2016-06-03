#!/usr/bin/env python
# -*- coding: utf-8 -*-

from __future__ import print_function

from DcardV2 import Comment
from Exceptions.InputError import InputError
import traceback
import Database
import requests
import random
import json
import time

comment = Comment.Comment()


def get_dcard_post(gearman_worker, gearman_job):
    global comment
    article_id = gearman_job.data
    try:
        posts = comment.get_comments(article_id)

        for post in posts:
            Comment.CommentsDatabase.update_one(
                {'id': post['id']},
                {
                    '$set': post
                },
                upsert=True
            )
            random_sleep = random.randrange(5, 10)
            print('[%s] Scraped %s, sleep %s sec(s).' % (post['id'], post['postId'], random_sleep))
            time.sleep(random_sleep)

    except KeyboardInterrupt:
        print('Bye~\n')
        exit()
    except requests.ConnectionError as e:
        print(e.message)
        Database.JobClient.submit_job(
            'dcard-v2-scrap-comments',
            gearman_job.data,
            background=True,
            priority=Database.gearman.PRIORITY_LOW
        )
        print('get %s error, sleep 30 minute(s).' % article_id)
        time.sleep(30 * 60)
    except Exception as e:
        print(e.message)
        Database.JobClient.submit_job(
            'dcard-v2-scrap-comments',
            gearman_job.data,
            background=True,
            priority=Database.gearman.PRIORITY_LOW
        )
        traceback.print_exc()
        print('get %s error' % article_id)
        exit()

    return 'ok'


def start_work():
    Database.JobWorker.register_task('dcard-v2-scrap-comments', get_dcard_post)
    Database.JobWorker.work()

if '__main__' == __name__:
    start_work()
