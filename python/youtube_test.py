#!/usr/bin/env python
# -*- coding: utf-8 -*-

import Youtube

scrap = Youtube.Scrap()

scrap.youtube_url = 'https://www.youtube.com/watch?v=DMgWkCwWnuw'

scrap.extract_info()
