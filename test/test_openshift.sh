#!/bin/bash

OSHTSRC="https://raw.githubusercontent.com/coryb/osht/master/osht.sh"
OSHT="osht.sh"
if test ! -f $OSHT ;
  then
  echo downloading $OSHT
  curl --progress-bar $OSHTSRC -o $OSHT
fi
. $OSHT

PLAN 11
RUNS docker --version
GREP "version 18.09.2"
RUNS docker-compose version
GREP "version 1.23.2"

#RUNS docker volume create mysql_data
#RUNS docker volume list
#GREP mysql_data

#RUNS docker run -d -p 3306:3306 -e MYSQL_ROOT_PASSWORD=mypassword -v mysql_data:/var/lib/mysql mysql:5.6 --character-set-server=utf8mb4 --collation-server=utf8mb4_general_ci
RUNS docker run -d -p 3306:3306 -e MYSQL_ROOT_PASSWORD=mypassword mysql:5.6 --character-set-server=utf8mb4 --collation-server=utf8mb4_general_ci
MYSQLCONTAINER=$(cat $OSHT_STDOUT)
echo MYSQLCONTAINER: $MYSQLCONTAINER

#RUNS docker volume create mautic_data

#RUNS docker run --rm -e MAUTIC_DB_HOST=127.0.0.1 -e MAUTIC_DB_USER=root -e MAUTIC_DB_PASSWORD=mypassword -e MAUTIC_DB_NAME=mautic -e MAUTIC_RUN_CRON_JOBS=true -e MAUTIC_TRUSTED_PROXIES=0.0.0.0/0 -p 8080:80 -v mautic_data:/var/www/html mautic/mautic:latest whoami
#cat $OSHT_STDOUT

RUNS docker run --name mautic -d --restart=always -e MAUTIC_DB_HOST=127.0.0.1 -e MAUTIC_DB_USER=root -e MAUTIC_DB_PASSWORD=mypassword -e MAUTIC_DB_NAME=mautic -e MAUTIC_RUN_CRON_JOBS=true -e MAUTIC_TRUSTED_PROXIES=0.0.0.0/0 -p 8080:80 mautic/mautic:latest
MAUTICCONTAINER=$(cat $OSHT_STDOUT)

RUNS docker exec "$MAUTICCONTAINER" whoami
GREP root

RUNS docker kill "$MAUTICCONTAINER"
RUNS docker rm "$MAUTICCONTAINER"

#RUNS docker volume remove mautic_data

RUNS docker kill "$MYSQLCONTAINER"

#RUNS docker volume remove mysql_data
#RUNS docker volume list
#NGREP mysql_data
