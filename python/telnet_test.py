# coding=utf-8
from Base import *
from scrapy import Selector
import requests
import gearman
import pymongo
import uniout
import hashlib
import time
import re

JobWorker = gearman.GearmanWorker([app_config['job']['gearman']])
Mongo = pymongo.MongoClient(host=app_config['db']['mongo'], socketTimeoutMS=None, socketKeepAlive=True)
Collection = Mongo['wulo']
Database = Collection['data']
RAWDB = Collection['raw']

_hash = hashlib.sha224()


# res = requests.get('https://www.ptt.cc/bbs/StupidClown/M.1457268374.A.827.html')
# res = requests.get('https://www.ptt.cc/bbs/StupidClown/M.1457268828.A.363.html')
# res = requests.get('https://www.ptt.cc/bbs/StupidClown/M.1457273711.A.902.html')
res = requests.get('https://www.ptt.cc/bbs/LGBT_SEX/M.1456717141.A.C4D.html', headers={
    'cookie': ';over18=1;'
})

if res.status_code == 200:
    _hash.update(res.url)
    hexhash = _hash.hexdigest()
    RAWDB.update_one(
        {'hash': hexhash},
        {
            '$set': {
                'url': res.url,
                'html': res.content,
                'hash': hexhash
            }
        }, upsert=True
    )

    article = {
        'url': res.url,
        'hash': hexhash
    }

    selector = Selector(text=res.content)
    body = selector.css('#main-content').extract()
    body = re.sub(ur'<div.+>.+</div>\n', '', body[0])
    body = re.sub(re.compile(ur'--.+', re.DOTALL), '', body)

    article['body'] = body

    for index, info in enumerate(selector.css('#main-content > div[class*="article-metaline"]')):
        title = info.css('span.article-meta-tag::text').extract()
        title = len(title) > 0 and title[0] or None

        if u'作者' == title:
            author = info.css('span.article-meta-value::text').extract()
            author = len(author) > 0 and author[0] or None
            author_regex = re.compile(ur'^(.+) \((.+)\)$')
            author = re.findall(author_regex, author)
            for _index, value in enumerate(author[0]):
                if 0 == _index:
                    article['author'] = value
                if 1 == _index:
                    article['nick'] = value

        if u'看板' == title:
            board = info.css('span.article-meta-value::text').extract()
            board = len(board) > 0 and board[0] or None
            if board:
                article['board'] = board

        if u'標題' == title:
            _title = info.css('span.article-meta-value::text').extract()
            _title = len(title) > 0 and _title[0] or None
            if _title:
                article['title'] = _title

        if u'時間' == title:
            # Sun Mar  6 20:46:11 2016
            date = info.css('span.article-meta-value::text').extract()
            date = len(title) > 0 and date[0] or None
            if date:
                article['date'] = int(time.mktime(time.strptime(date, "%a %b %d %H:%M:%S %Y")))

    for index, push in enumerate(selector.css('#main-content > div.push')):
        if index == 4:
            user = push.css('span.push-userid::text').extract()[0]
            symbol = push.css('span.push-tag::text').extract()[0]
            content = push.css('span.push-content::text').extract()[0]
            print user, symbol, content
            article['wulo'] = {
                'user': user,
                'symbol': symbol,
                'content': content
            }

    Database.update_one(
        {'hash': hexhash},
        {'$set': article},
        upsert=True
    )
