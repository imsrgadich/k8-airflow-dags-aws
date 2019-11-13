#!/usr/bin/env bash

## we do not recommend doing this since it is insecure, but for the purposes of saving time for the talk demo
## we will use this insecure alternative
## more at https://stackoverflow.com/questions/46664104/how-to-sign-in-kubernetes-dashboard
kubectl apply -f kubernetes-dashboard.yaml

# create a service account
kubectl create serviceaccount dashboard-admin-sa

# attach the service account to cluster admin role
kubectl create clusterrolebinding dashboard-admin-sa --clusterrole=cluster-admin --serviceaccount=default:dashboard-admin-sa

# Parse the token
# shellcheck disable=SC2046
TOKEN=$(kubectl describe secret $(kubectl -n kube-system get secret | awk '/^dashboard-admin-sa-token-/{print $1}') | awk '$1=="token:"{print $2}')

echo "========================================================================================="
echo "Use the below token to sign-in to the dashboard. This is after running open_dashboard.sh"
echo "========================================================================================="
echo "$TOKEN"



