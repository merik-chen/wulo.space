#!/usr/bin/env python
# -*- coding: utf-8 -*-
import sys
from os import path
sys.path.append(path.dirname(path.dirname(path.abspath(__file__))))

from Config import *
from Commons import *
from Exceptions.InputError import InputError
from scrapy import Selector
import requests
import datetime
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

Collection = Mongo['weather']
Database = Collection['history']


_hash = hashlib.sha1()

STATIONS = {"466880": ["板橋", "BANQIAO", "新北市"], "466900": ["淡水", "TAMSUI", "新北市"],
            "466910": ["鞍部", "ANBU", "臺北市"], "466920": ["臺北", "TAIPEI", "臺北市"],
            "466930": ["竹子湖", "ZHUZIHU", "臺北市"], "466940": ["基隆", "KEELUNG", "基隆市"],
            "466950": ["彭佳嶼", "PENGJIAYU", "基隆市"], "466990": ["花蓮", "HUALIEN", "花蓮縣"],
            "467050": ["新屋", "XINWU", "桃園市"], "467060": ["蘇澳", "SU-AO", "宜蘭縣"],
            "467080": ["宜蘭", "YILAN", "宜蘭縣"], "467110": ["金門", "KINMEN", "金門縣"],
            "467300": ["東吉島", "DONGJIDAO", "澎湖縣"], "467350": ["澎湖", "PENGHU", "澎湖縣"],
            "467410": ["臺南", "TAINAN", "臺南市"], "467420": ["永康", "YONGKANG", "臺南市"],
            "467440": ["高雄", "KAOHSIUNG", "高雄市"], "467480": ["嘉義", "CHIAYI", "嘉義市"],
            "467490": ["臺中", "TAICHUNG", "臺中市"], "467530": ["阿里山", "ALISHAN", "嘉義縣"],
            "467540": ["大武", "DAWU", "臺東縣"], "467550": ["玉山", "YUSHAN", "南投縣"],
            "467570": ["新竹", "HSINCHU", "新竹市"], "467590": ["恆春", "HENGCHUN", "屏東縣"],
            "467610": ["成功", "CHENGGONG", "臺東縣"], "467620": ["蘭嶼", "LANYU", "臺東縣"],
            "467650": ["日月潭", "SUN MOON LAKE", "南投縣"], "467660": ["臺東", "TAITUNG", "臺東縣"],
            "467770": ["梧棲", "WUQI", "臺中市"], "467780": ["七股", "QIGU", "臺南市"],
            "467990": ["馬祖", "MATSU", "連江縣"], "C0A530": ["坪林", "Pinglin", "新北市"],
            "C0A710": ["林口", "Linkou", "新北市"], "C0A880": ["福隆", "Fulong", "新北市"],
            "C0A940": ["金山", "Jinshan", "新北市"], "C0AC60": ["三峽", "Sanshia", "新北市"],
            "C0ACA0": ["新莊", "Xinzhuang", "新北市"], "C0C460": ["復興", "Fuxing", "桃園市"],
            "C0C480": ["桃園", "Taoyuan", "桃園市"], "C0C490": ["八德", "Bade", "桃園市"],
            "C0C520": ["中壢", "Zhongli (NCU)", "桃園市"],
            "C0C650": ["平鎮", "Pingjhen", "桃園市"], "C0C660": ["楊梅", "Yangmei", "桃園市"],
            "C0D360": ["梅花", "Meihua", "新竹縣"], "C0D390": ["關西", "Guanxi", "新竹縣"],
            "C0D430": ["峨眉", "Emei", "新竹縣"], "C0D540": ["橫山", "Hengshan", "新竹縣"],
            "C0D550": ["雪霸", "Xueba", "新竹縣"], "C0D560": ["竹東", "Zhudong", "新竹縣"],
            "C0D570": ["香山", "Siangshan", "新竹市"], "C0D650": ["湖口", "Hukou", "新竹縣"],
            "C0D660": ["新竹市東區", "Dongqu, Hsinshu City", "新竹市"],
            "C0E420": ["竹南", "Jhunan", "苗栗縣"], "C0E530": ["三義", "Sanyi", "苗栗縣"],
            "C0E590": ["通霄", "Tucheng", "苗栗縣"], "C0E750": ["苗栗", "Miaoli", "苗栗縣"],
            "C0E780": ["銅鑼", "Tongluo", "苗栗縣"], "C0E830": ["苑裡", "YUANLI", "苗栗縣"],
            "C0F850": ["東勢", "Dongshi", "臺中市"], "C0F861": ["梨山", "Lishan", "臺中市"],
            "C0F930": ["大甲", "Dajia", "臺中市"], "C0F9M0": ["豐原", "Fengyuan", "臺中市"],
            "C0F9X0": ["大雅(中科園區)", "Daya", "臺中市"], "C0G640": ["鹿港", "Lukang", "彰化縣"],
            "C0G650": ["員林", "Yuanlin", "彰化縣"], "C0G840": ["北斗", "Beidou", "彰化縣"],
            "C0H950": ["中寮", "Zhongliao", "南投縣"], "C0H960": ["草屯", "Caotun", "南投縣"],
            "C0H9A0": ["神木村", "Shenmu Village", "南投縣"],
            "C0H9C0": ["合歡山", "Hehuan Mountain", "南投縣"],
            "C0I010": ["廬山", "Lushan", "南投縣"], "C0I110": ["竹山", "Zhushan", "南投縣"],
            "C0K240": ["草嶺", "Caoling", "雲林縣"], "C0K250": ["崙背", "Lunbei", "雲林縣"],
            "C0K280": ["四湖", "Sihu", "雲林縣"], "C0K291": ["宜梧", "Yiwu", "雲林縣"],
            "C0K330": ["虎尾", "Huwei", "雲林縣"], "C0K530": ["臺西", "Taixi", "雲林縣"],
            "C0M410": ["馬頭山", "Matoushan", "嘉義縣"], "C0M680": ["太保", "Taibao", "嘉義縣"],
            "C0M710": ["東石", "Dongshi", "嘉義縣"], "C0M720": ["番路", "Fanlu", "嘉義縣"],
            "C0M760": ["民雄", "Minxiong", "嘉義縣"],
            "C0M770": ["嘉義梅山", "Meishan Chiayi County", "嘉義縣"],
            "C0O900": ["善化", "Shanhua", "臺南市"], "C0O910": ["新營", "Sinying", "臺南市"],
            "C0O930": ["玉井", "Yujing", "臺南市"], "C0O970": ["虎頭埤", "Hutoupi", "臺南市"],
            "C0O990": ["媽廟", "Mamiao", "臺南市"], "C0R150": ["三地門", "Sandimen", "屏東縣"],
            "C0R170": ["屏東", "Pingdong", "屏東縣"], "C0R190": ["赤山", "Chishan", "屏東縣"],
            "C0R400": ["楓港", "Fongkung", "屏東縣"], "C0R420": ["牡丹池山", "Mudanchihshan", "屏東縣"],
            "C0R430": ["東港", "Donggang", "屏東縣"], "C0R500": ["竹田", "Zhutian", "屏東縣"],
            "C0S700": ["知本", "Jhihben", "臺東縣"], "C0S710": ["鹿野", "Luye", "臺東縣"],
            "C0S730": ["綠島", "Lyudao", "臺東縣"], "C0S740": ["池上", "Chihshang", "臺東縣"],
            "C0S750": ["向陽", "Siangyang", "臺東縣"], "C0T820": ["天祥", "Tiansiang", "花蓮縣"],
            "C0T870": ["鯉魚潭", "Liyutan", "花蓮縣"], "C0T960": ["光復", "Guangfu", "花蓮縣"],
            "C0T9I0": ["豐濱", "Fongbin", "花蓮縣"], "C0U520": ["雙連埤", "Shuanglianpi", "宜蘭縣"],
            "C0U600": ["礁溪", "Chiaoshi", "宜蘭縣"], "C0U680": ["冬山", "Dongshan", "宜蘭縣"],
            "C0U710": ["太平山", "Taipingshan", "宜蘭縣"], "C0U760": ["東澳", "Dong-ao", "宜蘭縣"],
            "C0U770": ["南澳", "Nan-ao", "宜蘭縣"], "C0V250": ["甲仙", "Jiasian", "高雄市"],
            "C0V310": ["美濃", "Meinong", "高雄市"], "C0V440": ["鳳山", "Fengshan", "高雄市"],
            "C0V670": ["楠梓", "Nanzi", "高雄市"], "C0V710": ["苓雅", "LingYa", "高雄市"],
            "C0V740": ["旗山", "Qishan", "高雄市"], "C0V800": ["六龜", "Liugui", "高雄市"],
            "C0Z061": ["玉里", "Yuli", "花蓮縣"], "C1E451": ["象鼻", "Xiangbi", "苗栗縣"],
            "C1F9B1": ["桐林", "Tonglin", "臺中市"], "C1S820": ["金峰", "Jinfeng", "臺東縣"],
            "C1T930": ["鳳林", "Fonglin", "花蓮縣"], "C1U830": ["烏石鼻", "Wushibi", "宜蘭縣"],
            "C1U850": ["觀音海岸", "Guanyinhaian", "宜蘭縣"]}


