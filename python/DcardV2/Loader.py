import sys
from os import path
sys.path.append(path.dirname(path.dirname(path.abspath(__file__))))

from Config import *
from Commons import *
from Exceptions.InputError import InputError
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

Collection = Mongo['DcardV2']
Database = Collection['posts']
RawDatabase = Collection['raw_posts']
BoardsDatabase = Collection['boards']
CommentsDatabase = Collection['comments']


_hash = hashlib.sha1()

