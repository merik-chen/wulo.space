#!/usr/bin/env python
# -*- coding: utf-8 -*-

from Loader import *


class Article:
    def __init__(self):
        pass

    @staticmethod
    def get_article(board, article, with_raw=False):
        target = 'https://www.ptt.cc/bbs/%s/%s.html' % (board, article)

        resp = make_get_request(
            target,
            headers={
                'cookie': ';over18=1;'
            },
            is_json=False
        )

        if resp:

            article = {
                'url': target,
                'hash': make_sha1(target),
                'board': board,
                'article': article
            }

            selector = Selector(text=resp)
            body = selector.css('#main-content').extract()
            body = re.sub(ur'<div.+>.+</div>\n', '', body[0])
            body = re.sub(re.compile(ur'--.+', re.DOTALL), '', body)

            article['body'] = body

            for test in selector.css('span.f2::text'):
                vaild_ip_regex = re.compile(ur'(\d{1,3}\.\d{1,3}\.\d{1,3}\.\d{1,3})')
                text_txt = test.extract().encode('utf-8').strip()
                text_find = re.search(vaild_ip_regex, text_txt)
                if text_find:
                    ip = text_find.group()
                    article['ip'] = ip

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

                # if u'看板' == title:
                #     board = info.css('span.article-meta-value::text').extract()
                #     board = len(board) > 0 and board[0] or None
                #     if board:
                #         article['board'] = board

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

            if with_raw:
                return article, resp
            else:
                return article
        else:
            return None
