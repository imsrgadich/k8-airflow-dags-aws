#!/usr/bin/env bash

helm upgrade --recreate-pods -f /Users/imsrgadich/Documents/gitrepos/kube-airflow/airflow/values.yaml \
	             --install \
	             --debug \
	             airflow \
	             /Users/imsrgadich/Documents/gitrepos/kube-airflow/airflow
