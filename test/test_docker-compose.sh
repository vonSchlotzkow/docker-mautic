#!/bin/bash

. osht_init.sh

PLAN 6
RUNS docker-compose version
GREP "version 1.23.2"

RUNS docker-compose up --build -d
RUNS docker-compose exec -T mautic whoami
GREP ^root
RUNS docker-compose down
