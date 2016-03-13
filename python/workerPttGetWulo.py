#!/usr/bin/env python
# -*- coding: utf-8 -*-

from Ptt.Article import Article
import Database
import json

article = None


def ptt_get_article(gearman_worker, gearman_job):
    global article
    data = json.loads(gearman_job.data)
    result, raw = article.get_article(data['board'], data['article'], with_raw=True)

    Database.RawDatabase.update_one(
        {'hash': result['hash']},
        {
            '$set': {
                'url': result['url'],
                'html': raw,
                'hash': result['hash']
            }
        }, upsert=True
    )

    Database.Database.update_one(
        {'hash': result['hash']},
        {'$set': result},
        upsert=True
    )

    return 'ok'


def start_work():
    global article
    article = Article()
    Database.JobWorker.register_task('wulo-get-ptt-article', ptt_get_article)
    Database.JobWorker.work()

if '__main__' == __name__:
    start_work()
