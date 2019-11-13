#!/usr/bin/env bash

# shellcheck disable=SC2006
my_dir=`dirname $0`

# sync my dags
echo "Syncing the DAGs"
"${my_dir}"/sync_dag.sh

web_pod=$("${my_dir}"/get_pod.sh "web")

echo "current web pod"
echo "$web_pod"

function forward {
    kubectl port-forward --namespace default "${web_pod}" 8080:8080
    status=$?
}

forward

## continuously forward
while ! [[ "${status}" -eq 10 ]]; do
    echo "lost connection, reestablishing"
    forward
done


