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
Mongo = pymongo.MongoClient(
    host=app_cfg['mongo']['address'],
    port=app_cfg['mongo']['port'],
    socketTimeoutMS=None,
    socketKeepAlive=True
)
Collection = Mongo['Dcard']
Database = Collection['posts']
RawDatabase = Collection['raw_posts']


_hash = hashlib.sha1()

