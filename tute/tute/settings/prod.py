import os
from .base import *


SECRET_KEY = os.environ["DJANGO_SECRET_KEY"]
DEBUG = False
ALLOWED_HOSTS = ['localhost', '64.225.23.131', "mycoolwebsite.xyz", "www.mycoolwebsite.xyz"]
STATIC_ROOT = os.path.join(BASE_DIR, "staticfiles")
