#!/bin/bash
# Set up a new Ubuntu 18.04 server for deployment
set -e
# if [[ -z "$DJANGO_SECRET_KEY" ]]
# then
#     echo -e "\nERROR: No value set for DJANGO_SECRET_KEY."
#     exit 1
# fi
DJANGO_SETTINGS_MODULE="tute.settings.prod"
ssh root@$SERVER /bin/bash << EOF
    set -e
    echo -e "\n>>> Updating apt sources"
    apt-get -qq update
    echo -e "\n>>> Updating apt packages"
    apt-get -qq upgrade

    echo -e "\n>>> Installing required apt packages"
    apt-get -qq install python3-pip

    echo -e "\n>>> Installing virtualenv"
    pip3 install virtualenv

    echo -e "\n>>> Setting up project folder"
    mkdir -p /app/logs

    if [[ ! -d "/app/env" ]]
    then
        echo -e "\n>>> Creating virtualenv"
        virtualenv -p python3 /app/env
    else
        echo -e "\n>>> Skipping virtualenv creation"
    fi


    if [[ "\$DJANGO_SETTINGS_MODULE" != "$DJANGO_SETTINGS_MODULE" ]]
    then
        echo -e "\n>>> Setting DJANGO_SETTINGS_MODULE envar"
        echo -e "\nDJANGO_SETTINGS_MODULE=\"$DJANGO_SETTINGS_MODULE\"\n" >> /etc/environment
    else
        echo -e "\n>>> Skipping setting DJANGO_SETTINGS_MODULE envar"
    fi

    if [[ "\$DJANGO_SECRET_KEY" != "$DJANGO_SECRET_KEY" ]]
    then
        echo -e "\n>>> Setting DJANGO_SECRET_KEY envar"
        echo -e "\nDJANGO_SECRET_KEY=\"$DJANGO_SECRET_KEY\"\n" >> /etc/environment
    else
        echo -e "\n>>> Skipping setting DJANGO_SECRET_KEY envar"
    fi

    echo -e "\n>>> Setup finished"
EOF
