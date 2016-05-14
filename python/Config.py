import __future__
import traceback
import sys
import os
import re


app_env = 'APP_ENV' in os.environ and str(os.environ['APP_ENV']).lower() or ''

if app_env == 'spider':
    app_cfg = {
        'mongo': {'address': '192.168.10.251', 'port': 27017},
        'redis': {'address': '192.168.122.254', 'port': 6379},
        'gearman': {'address': '192.168.122.1', 'port': 4730},
        'memcached': {'address': '192.168.122.1', 'port': 11211},
        'mongo_replica': ['192.168.10.251:27017']
    }
elif app_env == 'master':
    app_cfg = {
        'mongo': {'address': '192.168.10.251', 'port': 27017},
        'redis': {'address': '192.168.10.251', 'port': 6379},
        'gearman': {'address': '192.168.10.254', 'port': 4730},
        'memcached': {'address': '192.168.10.254', 'port': 11211},
        'mongo_replica': ['192.168.10.251:27017']
    }
else:
    app_cfg = {
        'mongo': {'address': '192.168.10.251', 'port': 27017},
        'redis': {'address': '192.168.10.251', 'port': 6379},
        'gearman': {'address': '192.168.10.254', 'port': 4730},
        'memcached': {'address': '192.168.10.254', 'port': 11211},
        'mongo_replica': ['192.168.10.251:27017']
    }

