import multiprocessing

bind = "0.0.0.0:80"
workers = multiprocessing.cpu_count() * 2 + 1
# accesslog = "/app/logs/gunicorn.access.log"
# errorlog = "/app/logs/gunicorn.app.log"
# loglevel = "info"
# capture_output = True
