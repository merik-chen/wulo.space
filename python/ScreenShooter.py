#!/usr/bin/python
# -*- coding: utf-8 -*-

from selenium import webdriver
from xvfbwrapper import Xvfb
# from gridfs import GridFS
from bson import binary
from Database import *
from PIL import Image
import traceback
import hashlib
import time
import json
import uuid

screen_shooter = None


class ScreenShooter:

    display_depth = 24
    display_width = 1280
    display_height = 768

    def __init__(self, screen_width=1280, screen_height=768, screen_depth=24):
        self.display_depth = screen_depth
        self.display_width = (int(screen_width) + 0)
        self.screen_height = (int(screen_height) + 0)
        pass

    def setup_display(self, width=0, height=0, depth=0):
        depth = depth == 0 and self.display_depth or depth
        width = width == 0 and self.display_width or width
        height = height == 0 and self.display_height or height
        v_display = Xvfb(int(width) + 300, int(height) + 300, colordepth=int(depth))
        return v_display

    def get_screen_shot(self, url, _hash):

        display = self.setup_display()
        display.start()

        profile = webdriver.FirefoxProfile()
        # profile.set_preference("general.useragent.override", '')

        browser = webdriver.Firefox(profile)
        browser.add_cookie({'name': 'over18', 'value': '1'})
        browser.implicitly_wait(3)
        browser.get(url)
        browser.set_window_size(int(self.display_width), int(self.display_height))
        time.sleep(0.5)
        # browser.save_screenshot("")

        picture = browser.get_screenshot_as_png()

        browser.quit()
        display.stop()

        return self.save_to_mongo(_hash, picture, url)

    def save_to_mongo(self, _hash, picture, url):
        # mongo_gfs = GridFS(Mongo['screenshot'])

        _file = '/tmp/%s.png' % _hash
        _t_file = '/tmp/%s_t.png' % _hash

        _pic = open(_file, 'w')
        _pic.write(picture)
        _pic.close()

        size = 260, 150
        im = Image.open(_file)
        im.crop((0, 0, self.display_width, self.display_height)).save(_file)
        im.thumbnail(size, Image.ANTIALIAS)
        im.save(_t_file)

        _thum = binary.Binary(open(_t_file, mode='rb').read())
        _binary = binary.Binary(open(_file, mode='rb').read())

        os.remove(_file)
        os.remove(_t_file)

        return Mongo['screenshot']['store'].update_one(
            {'hash': _hash},
            {
                '$set': {
                    'url': url,
                    'hash': _hash,
                    'uuid': str(uuid.uuid4()),
                    'file': _binary,
                    'thumbnail': _thum,
                    'content-type': 'image/png'
                }
            }, upsert=True
        )

        # return mongo_gfs.put(
        #     picture,
        #     url=url,
        #     hash=_hash,
        #     uuid=str(uuid.uuid4()),
        # )


def worker(gearman_worker, gearman_job):
    global screen_shooter
    try:
        data = json.loads(gearman_job.data)
        print screen_shooter.get_screen_shot(
            data['url'],
            hashlib.sha1(data['url']).hexdigest()
        )

        time.sleep(1)

        return 'ok'
    except KeyboardInterrupt:
        print ('Bye~\n')
        exit()
    except 'Exception':
        traceback.print_exc()
        exit()


def start_work():
    JobWorker.register_task('scrap-screenshot', worker)
    JobWorker.work()


if '__main__' == __name__:
    screen_shooter = ScreenShooter()
    start_work()



