#!/usr/bin/env python
# -*- coding: utf-8 -*-

from Ptt.Article import Article
import Database
import Commons
import random
import json
import time

article = None


def ptt_get_article(gearman_worker, gearman_job):
    global article
    data = json.loads(gearman_job.data)
    target = 'https://www.ptt.cc/bbs/%s/%s.html' % (data['board'], data['article'])
    hash = Commons.make_sha1(target)

    find = Database.Database.find_one({'hash': hash})

    if find:
        print "Fetched, skip."
        return 'ok'
    else:
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

        if 'title' in result:
            if 'wulo' in result:
                # board <-> user relations
                Database.Redis.zincrby(
                    'bd:' + data['board'].encode('utf-8'),
                    'ur:' + result['wulo']['user'].encode('utf-8'),
                    1
                )

                # user <-> board relations
                Database.Redis.zincrby(
                    'ur:' + result['wulo']['user'].encode('utf-8'),
                    'bd:' + data['board'].encode('utf-8'),
                    1
                )

            # board <-> articles
            Database.Redis.rpush(
                data['board'].encode('utf-8'),
                data['article'].encode('utf-8'),
            )

            # global <-> articles
            Database.Redis.hset(
                'allArticlesList',
                data['article'].encode('utf-8'),
                data['board'].encode('utf-8')
            )
            # global <-> boards
            Database.Redis.zincrby(
                'allBoardsList',
                data['board'].encode('utf-8'),
                1
            )

            # global <-> articles
            Database.Redis.sadd(
                'allArticlesSets',
                json.dumps({
                    'board': data['board'].encode('utf-8'),
                    'article': data['article'].encode('utf-8')
                }),
            )
            # global <-> boards
            Database.Redis.sadd(
                'allBoardsSets',
                data['board'].encode('utf-8'),
            )

        time.sleep(random.randrange(3, 6))

        return 'ok'


def start_work():
    global article
    article = Article()
    Database.JobWorker.register_task('wulo-get-ptt-article', ptt_get_article)
    Database.JobWorker.work()

if '__main__' == __name__:
    start_work()
