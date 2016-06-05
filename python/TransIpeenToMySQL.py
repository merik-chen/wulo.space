#!/usr/bin/env python
# -*- coding: utf-8 -*-

import MySQLdb
import pymongo

mysql = MySQLdb.connect(
    host='aws-free-tire.cmq3vy9ka3vg.ap-northeast-1.rds.amazonaws.com',
    user='merik',
    passwd='merik1316',
    db='ipeen'
)
mysql.autocommit(True)
cursor = mysql.cursor()

query = '''INSERT INTO stores (hash, description, locality, region, telephone, longitude, latitude, street, priceRange, address, postalCode, name, link, geo) VALUES (%s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, Point(%s, %s))'''

mongo = pymongo.MongoClient(host='192.168.10.251')

start_count = 0
total_count = mongo['ipeen']['stores'].count()

for store in mongo['ipeen']['stores'].find(no_cursor_timeout=True):
    start_count += 1
    if ('longitude' in store) and ('latitude' in store):
        if store['longitude'] and store['latitude']:
            cursor.execute('SELECT id, name FROM stores WHERE hash = "%s" LIMIT 1' % store['hash'])
            find = cursor.fetchone()
            if not find:
                cursor.execute(
                    query,
                    (
                        store['hash'],
                        store['description'],
                        store['locality'],
                        store['region'],
                        store['telephone'],
                        float(store['longitude']),
                        float(store['latitude']),
                        store['streetAddress'],
                        int(store['priceRange']),
                        store['address'],
                        int(store['postalCode']),
                        store['name'],
                        store['link'],
                        float(store['latitude']),
                        float(store['longitude'])
                    )
                )
                print('Store: %s added.' % store['name'].encode('utf-8'))

    if (start_count % 1000) == 0:
        print('Processing: %s / %s.' % (start_count, total_count))

