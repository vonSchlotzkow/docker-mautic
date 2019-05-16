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

RUNS docker volume create mysql_data
RUNS docker volume list
GREP mysql_data
RUNS docker volume remove mysql_data
RUNS docker volume list
NGREP mysql_data
