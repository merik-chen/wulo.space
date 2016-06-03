#!/usr/bin/env python
# -*- coding: utf-8 -*-

from __future__ import print_function

from DcardV2 import Article
from Exceptions.InputError import InputError
import traceback
import Database
import requests
import random
import json
import time

article = Article.Article()


def get_dcard_post(gearman_worker, gearman_job):
    global article
    article_id = gearman_job.data
    try:
        post = article.get_article(article_id)

        if '_id' in post:
            post['article_id'] = post['_id']
            del post['_id']

        if 'you' in post:
            del post['you']

        post['fetched'] = True

        Article.RawDatabase.find_one_and_update(
            {'id': post['id']},
            {
                '$set': post
            }
        )

        Database.JobClient.submit_job(
            'dcard-v2-scrap-comments',
            str(post['id']),
            background=True,
            unique=str(post['id'])
        )

        random_sleep = random.randrange(5, 10)
        print('[%s] Scraped %s, sleep %s sec(s).' % (post['id'], post['title'].encode('utf-8'), random_sleep))
        time.sleep(random_sleep)

    except KeyboardInterrupt:
        print('Bye~\n')
        exit()
    except InputError as e:
        print(e.message)
        Article.RawDatabase.find_one_and_update(
            {'id': article_id},
            {
                '$set': {
                    'fetched': True,
                    'error': True
                }
            }
        )
        time.sleep(5)
    except requests.ConnectionError as e:
        print(e.message)
        Database.JobClient.submit_job(
            'dcard-v2-scrap-post',
            gearman_job.data,
            background=True,
            priority=Database.gearman.PRIORITY_LOW
        )
        print('get %s error, sleep 30 minute(s).' % article_id)
        time.sleep(30 * 60)
    except Exception as e:
        print(e.message)
        Database.JobClient.submit_job(
            'dcard-v2-scrap-post',
            gearman_job.data,
            background=True,
            priority=Database.gearman.PRIORITY_LOW
        )
        traceback.print_exc()
        print('get %s error' % article_id)
        exit()

    return 'ok'


def start_work():
    Database.JobWorker.register_task('dcard-v2-scrap-post', get_dcard_post)
    Database.JobWorker.work()

if '__main__' == __name__:
    start_work()
