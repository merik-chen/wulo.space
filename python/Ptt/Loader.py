import sys
from os import path
sys.path.append(path.dirname(path.dirname(path.abspath(__file__))))

from Config import *
from Commons import *
from scrapy import Selector
import requests
import gearman
import pymongo
import uniout
import hashlib
import time
import re

JobClient = gearman.GearmanClient([app_cfg['gearman']['address'] + ':' + str(app_cfg['gearman']['port'])])
JobWorker = gearman.GearmanWorker([app_cfg['gearman']['address'] + ':' + str(app_cfg['gearman']['port'])])
# Mongo = pymongo.MongoClient(
#     host=app_cfg['mongo']['address'],
#     port=app_cfg['mongo']['port'],
#     socketTimeoutMS=None,
#     socketKeepAlive=True
# )

Mongo = pymongo.MongoClient(
    app_cfg['mongo_replica'],
    replicaset='dbrepl',
    socketTimeoutMS=None,
    socketKeepAlive=True
)

Collection = Mongo['YBS']
Database = Collection['serp']
PostDatabase = Collection['posts']


_hash = hashlib.sha224()

