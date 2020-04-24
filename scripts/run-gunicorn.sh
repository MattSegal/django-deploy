#!/bin/bash
# Run Gunicorn for the tute Django app
set -e
. env/bin/activate
cd tute
gunicorn tute.wsgi:application --bind 0.0.0.0:80

# Later ...
# gunicorn tute.wsgi:application -c config/gunicorn.conf.py
