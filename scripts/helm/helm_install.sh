#!/usr/bin/env bash

# shellcheck disable=SC2164
cd /Users/imsrgadich/Documents/gitrepos/kube-airflow/airflow

# run dependency update
helm dependency update

cd /Users/imsrgadich/Documents/gitrepos/kube-airflow/

# install kube-airflow
# kubectl create -f airflow.all.yaml

function helm_install {
    make helm-install NAMESPACE=kube-system HELM_VALUES=/Users/imsrgadich/Documents/gitrepos/kube-airflow/airflow/values.yaml
    status=$?
}

helm_install

while ! [[ "${status}" -eq 0 ]]; do
    echo "not ready"
    sleep 2s
    helm_install
done



