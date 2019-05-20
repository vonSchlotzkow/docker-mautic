#!/bin/bash

OSHTSRC="https://raw.githubusercontent.com/coryb/osht/master/osht.sh"
OSHT="osht.sh"
if test ! -f $OSHT ;
  then
  echo downloading $OSHT
  curl --progress-bar $OSHTSRC -o $OSHT
fi
. $OSHT
