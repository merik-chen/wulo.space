#!/usr/bin/env python
# -*- coding: utf-8 -*-

from CWB.History import History
from Exceptions.InputError import InputError
import traceback
import Database
import requests
import random
import json
import time

# cwb-get-weather

cwb_history = History()
Database.Collection = Database.Mongo['weather']
Database.Database = Database.Collection['history']


def cwb_get_weather(gearman_worker, gearman_job):
    data = json.loads(gearman_job.data)
    try:
        print ('Processing: %s, %s\t' % (data['date'], data['station'])),

        exists = Database.Database.find_one({
            'station': data['station'],
            'date': data['date']
        })

        if exists is None:
            result = cwb_history.get_daily_weather(data['station'], data['date'])

            Database.Database.find_one_and_update(
                {
                    'station': data['station'],
                    'date': data['date']
                },
                {
                    '$set':  result
                }, upsert=True
            )

            print ('...done')

            time.sleep(random.randrange(60, 120))
        else:
            print ('...skipped')

        return 'ok'
    except KeyboardInterrupt:
        print ('Bye~\n')
        exit()
    except Exception as e:
        print (e.message)
        Database.JobClient.submit_job(
            'cwb-get-weather',
            gearman_job.data,
            background=True,
            priority=Database.gearman.PRIORITY_LOW
        )
        traceback.print_exc()
        print ('get %s:%s error' % (data['station'], data['date']))
        exit()


def start_work():
    Database.JobWorker.register_task('cwb-get-weather', cwb_get_weather)
    Database.JobWorker.work()

if '__main__' == __name__:
    start_work()
