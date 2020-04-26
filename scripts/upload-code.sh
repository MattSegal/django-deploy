#!/bin/bash
set -e

echo -e "\n>>> Copying Django project files to server."
if [[ -z "$SERVER" ]]
then
    echo "ERROR: No value set for SERVER."
    exit 1
fi
echo -e "\n>>> Preparing scripts locally."
rm -rf deploy
mkdir deploy
cp -r config deploy
cp -r scripts deploy
cp -r tute deploy
cp requirements.txt deploy

echo -e "\n>>> Copying files to the server."
ssh root@$SERVER "rm -rf /root/deploy/"
scp -r deploy root@$SERVER:/root/

echo -e "\n>>> Cleaning up deployed files on the server."
ssh root@$SERVER /bin/bash << EOF
    set -e
    find /root/deploy/ -name *.pyc -delete
    find /root/deploy/ -name __pycache__ -delete
    find /root/deploy -type f -print0 | xargs -0 dos2unix
EOF

echo -e "\n>>> Finished copying Django project files to server."
