#!/bin/bash
# Install Django code on the target server
SERVER=64.225.23.131
set -e
# if [[ -z "$SERVER" ]]
# then
#     echo -e "\nERROR: No value set for SERVER."
#     exit 1
# fi

echo -e "\n>>>Installing app on server $SERVER"
ssh root@$SERVER /bin/bash << EOF
    set -e
    echo -e "\n>>>Stopping Gunicorn"
    supervisorctl stop gunicorn

    echo -e "\n>>>Deleting old app files"
    rm /app/requirements.txt
    rm -rf /app/config/
    rm -rf /app/tute/

    echo -e "\n>>>Copying new app files"
    cp /root/deploy/requirements.txt /app/
    rm -rf /root/deploy/config/ /app/
    rm -rf /root/deploy/tute/ /app/

    echo -e "\n>>>Installing Python requirements"
    cd /app/
    . env/bin/activate
    pip install -r requirements.txt

    echo -e "\n>>>Running Django migrations"
    cd tute
    ./manage.py migrate

    echo -e "\n>>>Running Django migrations"
    ./manage.py collectstatic

    echo -e "\n>>>Install finished"
    ls /app/
    tree /app/logs
    tree /app/tute
    tree /app/config

    echo -e "\n>>>Re-reading Supervisor config"
    supervisorctl reread

    echo -e "\n>>>Starting Gunicorn"
    supervisorctl start gunicorn
EOF
echo -e "\n>>>Install finished"
