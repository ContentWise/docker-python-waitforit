#!/bin/bash

set -e

# Both space and comma separated values are allowed

for i in ${WAIT_FOR//,/ }
do
    # Check port was correctly specified
    test "${i#*:}" != "$i" || { echo "[ERROR] Missing port for service '$i'. Exiting now!" ; exit 1; }
    
    # Wait for service to be ready
    /usr/local/bin/waitforit -host ${i%:*} -port ${i#*:} -retry $MILLIS_BETWEEN_WAIT_RETRIES -timeout $SECONDS_TO_WAIT -debug
done

for i in ${WAIT_FOR_ELASTICSEARCH//,/ }
do
    # Check port was correctly specified
    test "${i#*:}" != "$i" || { echo "[ERROR] Missing port for service '$i'. Exiting now!" ; exit 1; }
    
    # Wait for service to be ready
    /usr/local/bin/waitforit -host ${i%:*} -port ${i#*:} -retry $MILLIS_BETWEEN_WAIT_RETRIES -timeout $SECONDS_TO_WAIT -debug

    echo "Waiting for elastic search ${ELASTICSEARCH_WAIT_FOR_STATUS} status"
    wget -q "http://${i%:*}:${i#*:}/_cluster/health?wait_for_status=${ELASTICSEARCH_WAIT_FOR_STATUS}&timeout=${SECONDS_TO_WAIT}s" -O /dev/null || { echo "[ERROR] Could not wait for elasticsearch" ; exit 1; }
done

exec $@