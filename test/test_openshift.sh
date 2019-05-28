#!/bin/bash

. osht_init.sh

DELAY=0

PLAN 14
RUNS oc version
GREP "oc v3.11.0"
GREP "kubernetes v1.11.0"
GREP "openshift v3.11.82"

RUNS oc status
GREP "In project mymautic on server"


#RUNS oc new-project mymautic
RUNS oc create -f dc-mysql.yaml
GREP 'deploymentconfig.apps.openshift.io/mysql created'
sleep $DELAY
RUNS oc create -f svc-mysql.yaml
GREP 'service/mysql created'

sleep $DELAY

RUNS oc delete -f svc-mysql.yaml
GREP 'service "mysql" deleted'
sleep $DELAY

RUNS oc delete -f dc-mysql.yaml
GREP 'deploymentconfig.apps.openshift.io "mysql" deleted'

#RUNS oc delete dc/mysql
#RUNS docker-compose up --build -d
#sleep 5
#RUNS docker-compose exec mautic whoami
#GREP ^root

#RUNS docker-compose down
