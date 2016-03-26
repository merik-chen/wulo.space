#!/usr/bin/env python
# -*- coding: utf-8 -*-

from Loader import *
import pprint
import time


class History:

    HISTORY_START_DATE = datetime.date(2012, 12, 31)
    ENDPOINT_URL = 'http://e-service.cwb.gov.tw/'
    ENDPOINT_PATH = 'HistoryDataQuery/DayDataController.do?command=viewMain&station=%s&datepicker=%s'
    ENDPOINT_HEADER = {
        'Referer': 'http://e-service.cwb.gov.tw/HistoryDataQuery/index.jsp'
    }

    def __init__(self):
        pass

    def shift_time(self):
        self.HISTORY_START_DATE = self.HISTORY_START_DATE + datetime.timedelta(days=1)
        return self.HISTORY_START_DATE

    def str_time(self, _format='%Y-%m-%d'):
        return self.HISTORY_START_DATE.strftime(_format)

    @staticmethod
    def num(s):
        try:
            try:
                return int(s)
            except ValueError:
                return float(s)
        except ValueError:
            return s

    def get_daily_weather(self, station, date):
        target = self.ENDPOINT_URL + self.ENDPOINT_PATH % (station, date)
        r = make_get_request(target, headers=self.ENDPOINT_HEADER, is_json=False)
        if r:
            selector = Selector(text=r)
            today = {
                'station': station,
                'date': date,
                'timestamp': int(time.mktime(self.HISTORY_START_DATE.timetuple())),
                'data': {}
            }.copy()
            for index, tr in enumerate(selector.css('table#MyTable tr')):
                if index >= 2:
                    i = str(index - 1)
                    today['data'][i] = {}.copy()
                    for _index, data in enumerate(tr.css('tr td::text').extract()):
                        value = data.strip(u'\xa0')
                        value = len(value) > 0 and self.num(value.encode('utf-8')) or None
                        if _index == 0:
                            today['data'][i]['ObsTime'] = value
                        if _index == 1:
                            today['data'][i]['StnPres'] = value
                        if _index == 2:
                            today['data'][i]['SeaPres'] = value
                        if _index == 3:
                            today['data'][i]['Temperature'] = value
                        if _index == 4:
                            today['data'][i]['Td_dew_po'] = value
                        if _index == 5:
                            today['data'][i]['RH'] = value
                        if _index == 6:
                            today['data'][i]['WS'] = value
                        if _index == 7:
                            today['data'][i]['WD'] = value
                        if _index == 8:
                            today['data'][i]['WSGust'] = value
                        if _index == 9:
                            today['data'][i]['WDGust_360degree'] = value
                        if _index == 10:
                            today['data'][i]['Precp'] = value
                        if _index == 11:
                            today['data'][i]['PrecpHour'] = value
                        if _index == 12:
                            today['data'][i]['SunShine'] = value
                        if _index == 13:
                            today['data'][i]['GloblRad'] = value
                        if _index == 14:
                            today['data'][i]['Visb'] = value

            return today

if '__main__' == __name__:
    weatherHistory = History()
    while True:
        now_date = weatherHistory.shift_time()
        now_ts = int(time.mktime(now_date.timetuple()))
        timeStr = weatherHistory.str_time()
        is_big = now_ts >= int(time.time())
        if is_big:
            break
        else:
            print timeStr, is_big
            for station_id, _station in STATIONS.items():
                data = weatherHistory.get_daily_weather(station_id, timeStr)
                pprint.pprint(data)

                Database.find_one_and_update(
                    {
                        'station': data['station'],
                        'date': data['date']
                    },
                    {
                        '$set':  data
                    }, upsert=True
                )

                time.sleep(random.randrange(60, 120))
    # timeStr = weatherHistory.str_time()
    # weatherHistory.get_daily_weather(466910, timeStr)

    # for station_id, station in STATIONS.items():
    #     print station_id
