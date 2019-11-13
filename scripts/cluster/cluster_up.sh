#!/usr/bin/env bash

my_dir=`dirname $0`
ZONES="eu-central-1a"

kops create cluster \
--cloud aws \
--node-count 2 \
--node-size m3.large \
--master-size t2.large \
--zones $ZONES \
--master-zones ${ZONES} \
--name ${KOPS_CLUSTER_NAME} \
--state ${KOPS_STATE_STORE} \
--yes

# set the context to your local cluster
echo "setting the context"
kops export kubecfg

echo "spinning up cluster"
kops update cluster --name ${KOPS_CLUSTER_NAME} --yes

# restart the cluster
kops rolling-update cluster

# check if the cluster is up in a loop
echo "check if cluster is up"
"${my_dir}"/loop_validate.sh

echo "set up dashboard"
"${my_dir}"/setup_dashboard.sh

echo "open dashboard"
"${my_dir}"/open_dashboard.sh