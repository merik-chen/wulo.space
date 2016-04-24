#!/usr/bin/env python
# -*- coding: utf-8 -*-

from Config import *
import gearman
import pymongo
import redis

JobClient = gearman.GearmanClient([app_cfg['gearman']['address'] + ':' + str(app_cfg['gearman']['port'])])
JobWorker = gearman.GearmanWorker([app_cfg['gearman']['address'] + ':' + str(app_cfg['gearman']['port'])])
Mongo = pymongo.MongoClient(
    host=app_cfg['mongo']['address'],
    port=app_cfg['mongo']['port'],
    replicaset='dbrepl',
    socketTimeoutMS=None,
    socketKeepAlive=True
)
Collection = Mongo['wulo']
Database = Collection['data']
RawDatabase = Collection['raw']

Redis = redis.Redis(host=app_cfg['redis']['address'])
