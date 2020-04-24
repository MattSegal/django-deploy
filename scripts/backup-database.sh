#!/bin/bash
# Backup database on the target server.
set -e
if [[ -z "$SERVER" ]]
then
    echo -e "\nERROR: No value set for SERVER."
    exit 1
fi
echo -e "\n>>>Backing up database on server $SERVER"
TIME=$(date "+%s")
DBNAME="db.$TIME.sqlite3"
ssh root@$SERVER /bin/bash << EOF
    set -e
    mkdir -p /root/backups
    cp /app/db.sqlite3 /root/backups/$DBNAME
EOF
echo -e "\n>>>Backup finished"
