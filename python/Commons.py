#!/usr/bin/env python
# -*- coding: utf-8 -*-

import requests
import hashlib


def make_get_request(url, payload=None, headers=None, is_json=True):
    req = requests.get(
        url,
        params=payload,
        headers=headers and headers or {}
    )

    if 200 >= req.status_code <= 299:
        if is_json:
            return req.json()
        else:
            return req.content
    else:
        return None


def make_sha1(text):
    m = hashlib.sha1()
    m.update(text)
    return m.hexdigest()
