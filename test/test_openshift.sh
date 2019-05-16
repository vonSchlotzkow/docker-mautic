#!/bin/bash

OSHTSRC="https://raw.githubusercontent.com/coryb/osht/master/osht.sh"
OSHT="osht.sh"
if test ! -f $OSHT ;
  then
  echo downloading $OSHT
  curl --progress-bar $OSHTSRC -o $OSHT
fi
. $OSHT

PLAN 10
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

RUNS docker kill "$MYSQLCONTAINER"

#RUNS docker volume remove mysql_data
#RUNS docker volume list
#NGREP mysql_data
