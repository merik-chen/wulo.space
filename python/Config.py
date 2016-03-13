import __future__
import traceback
import sys
import os
import re


app_env = 'app_env' in os.environ and str(os.environ['app_env']).lower() or ''

if app_env == 'SPIDER':
    app_cfg = {
        'mongo': {'address': '192.168.122.1', 'port': 27017},
        'redis': {'address': '192.168.122.1', 'port': 6384},
        'gearman': {'address': '192.168.122.1', 'port': 4730},
        'memcached': {'address': '192.168.122.1', 'port': 11211},
    }
elif app_env == 'master':
    app_cfg = {
        'mongo': {'address': '192.168.10.254', 'port': 27017},
        'redis': {'address': '192.168.10.254', 'port': 6384},
        'gearman': {'address': '192.168.10.254', 'port': 4730},
        'memcached': {'address': '192.168.10.254', 'port': 11211},
    }
else:
    app_cfg = {
        'mongo': {'address': '192.168.10.254', 'port': 27017},
        'redis': {'address': '192.168.10.254', 'port': 6384},
        'gearman': {'address': '192.168.10.254', 'port': 4730},
        'memcached': {'address': '192.168.10.254', 'port': 11211},
    }


