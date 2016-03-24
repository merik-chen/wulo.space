#!/usr/bin/env python
# -*- coding: utf-8 -*-

from Dcard import Article
from Exceptions.InputError import InputError
import traceback
import Database
import random
import json
import time

article = Article.Article()


def get_dcard_post(gearman_worker, gearman_job):
    global article
    try:
        data = json.loads(gearman_job.data)
        board = data['board']
        article_id = data['article']

        post = article.get_article(board, article_id)

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

        random_sleep = random.randrange(10, 30)
        print '[%s] Scraped %s, sleep %s sec(s).' % (post['id'], post['version'][-1]['title'].encode('utf-8'), random_sleep)
        time.sleep(random_sleep)

    except KeyboardInterrupt:
        print 'Bye~\n'
        exit()
    except InputError as e:
        print e.message
    except Exception as e:
        print e.message
        Database.JobClient.submit_job(
            'dcard-scrap-post',
            gearman_job.data,
            background=True,
            priority=Database.gearman.PRIORITY_LOW
        )
        traceback.print_exc()
        print 'get %s error'
        exit()

    return 'ok'


def start_work():
    Database.JobWorker.register_task('dcard-scrap-post', get_dcard_post)
    Database.JobWorker.work()

if '__main__' == __name__:
    start_work()
