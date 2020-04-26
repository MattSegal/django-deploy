#!/bin/bash
set -e
# Backs up remote database and copies to local
echo -e "\n >>> Backing up database on $SERVER"
if [[ -z "$SERVER" ]]
then
    echo "ERROR: No value set for SERVER."
    exit 1
fi
TIME=$(date "+%s")
DBNAME="db.$TIME.sqlite3"
ssh root@$SERVER /bin/bash << EOF
set -e
mkdir -p /root/backups/
cp /app/db.sqlite3 /root/backups/$DBNAME
EOF
mkdir -p ~/backups/
scp root@tuteserver:/root/backups/* ~/backups/
