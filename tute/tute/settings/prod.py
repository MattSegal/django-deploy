import os
from .base import *

DEBUG = False
SECRET_KEY = os.environ['DJANGO_SECRET_KEY']
ALLOWED_HOSTS = ['localhost', '64.225.23.131', '127.0.0.1']
STATIC_ROOT = os.path.join(BASE_DIR, 'staticfiles')
