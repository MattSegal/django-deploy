#!/bin/bash
# Install Django app on server.
set -e
echo -e "\n>>> Installing Django project on server."
if [[ -z "$SERVER" ]]
then
    echo "ERROR: No value set for SERVER."
    exit 1
fi
ssh root@$SERVER /bin/bash << EOF
set -e
echo -e "\n>>> Stopping Gunicorn"
cd /app/
. env/bin/activate
./scripts/super.sh stop gunicorn

echo -e "\n>>> Deleting old files"
rm -rf /app/tute
rm -rf /app/config
rm -rf /app/scripts
rm requirements.txt

echo -e "\n>>> Copying new files"
cp -r /root/deploy/tute /app/
cp -r /root/deploy/config /app/
cp -r /root/deploy/scripts /app/
cp /root/deploy/requirements.txt /app/

echo -e "\n>>> Installing Python packages"
pip install -r /app/requirements.txt

echo -e "\n>>> Running Django migrations"
pushd tute
./manage.py migrate

echo -e "\n>>> Collecting static files"
./manage.py collectstatic
popd

echo -e "\n>>> Re-reading Supervisord config"
./scripts/super.sh reread

echo -e "\n>>> Starting Gunicorn"
./scripts/super.sh start gunicorn

EOF

echo -e "\n>>> Finished installing Django project on server."
