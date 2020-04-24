#!/bin/bash
# Copies Django project to target server.
set -e
SERVER=64.225.23.131
# if [[ -z "$SERVER" ]]
# then
#     echo -e "\nERROR: No value set for SERVER."
#     exit 1
# fi
echo -e "\n>>>Copying Django project files to server $SERVER"

echo -e "\n>>>Creating local tempoary deploy dir"
rm -rf deploy
mkdir deploy

echo -e "\n>>>Copying files to local tempoary deploy dir"
cp requirements.txt deploy
cp -r tute deploy
cp -r scripts deploy
cp -r config deploy

echo -e "\n>>>Uploading files to server $SERVER"
ssh root@\$SERVER "rm -rf /root/deploy/"
scp -r deploy root@\$SERVER:/root/
rm -rf deploy

echo -e "\n>>>Cleaning files on server $SERVER"
ssh root@$SERVER /bin/bash << EOF
    set -e
    cd /root/deploy/
    find -name \*.pyc -delete
    find -name **pycache** -delete
    dos2unix something something

    echo -e "\n>>>Files cleaned:"
    tree /root/deploy/
EOF
echo -e "\n>>>Finished copying Django project files to server $SERVER"
