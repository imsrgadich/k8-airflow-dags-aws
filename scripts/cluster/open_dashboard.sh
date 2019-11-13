#!/usr/bin/env bash


kubectl proxy --port=8002


/usr/bin/open -a "/Applications/Google Chrome.app" "http://localhost:8002/api/v1/namespaces/kube-system/services/https:kubernetes-dashboard:/proxy/"