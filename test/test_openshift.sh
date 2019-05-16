#!/bin/bash

OSHTSRC="https://raw.githubusercontent.com/coryb/osht/master/osht.sh"
OSHT="osht.sh"
if test ! -f $OSHT ;
  then
  echo downloading $OSHT
  curl --progress-bar $OSHTSRC -o $OSHT
fi
. $OSHT

PLAN 4
RUNS docker --version
GREP "version 18.09.2"
RUNS docker-compose version
GREP "version 1.23.2"
