# Installation instructions for MacOS

## To install AWS-CLI

```
curl "https://s3.amazonaws.com/aws-cli/awscli-bundle.zip" -o "awscli-bundle.zip"
unzip awscli-bundle.zip
sudo ./awscli-bundle/install -i /usr/local/aws -b /usr/local/bin/aws
```

## To install KOPS

`brew update && brew install kops`

## To install KUBECTL

`brew install kubectl`


# Misc commands

## To get the availability zones 
`aws ec2 describe-availability-zones --region eu-north-1`

```
{
    "AvailabilityZones": [
        {
            "State": "available",
            "Messages": [],
            "RegionName": "eu-north-1",
            "ZoneName": "eu-north-1a",
            "ZoneId": "eun1-az1"
        },
        {
            "State": "available",
            "Messages": [],
            "RegionName": "eu-north-1",
            "ZoneName": "eu-north-1b",
            "ZoneId": "eun1-az2"
        },
        {
            "State": "available",
            "Messages": [],
            "RegionName": "eu-north-1",
            "ZoneName": "eu-north-1c",
            "ZoneId": "eun1-az3"
        }
    ]
}
```

## To create the bucket
`aws s3api create-bucket --bucket srikanth-kops-state-store-1 --region eu-north-1 --create-bucket-configuration LocationConstraint=eu-north-1`

## Eanble versionering of the bucket
`aws s3api put-bucket-versioning --bucket srikanth-kops-state-store-4 --versioning-configuration Status=Enabled`

## Set the environment variables

```
export KOPS_CLUSTER_NAME=srikanth.k8s.local
export KOPS_STATE_STORE=s3://srikanth-kops-state-store-4
export AWS_REGION=eu-central-1
```

## AWS local configuration file

`vi  /Users/imsrgadich/.aws/config`

## Tutorial 
https://pattern-match.com/blog/2019/01/30/k8s-tutorial-part01-setup-on-aws/


killall kubectl

## for creating dashboard
https://www.replex.io/blog/how-to-install-access-and-add-heapster-metrics-to-the-kubernetes-dashboard

# Kubernetes signin
https://stackoverflow.com/questions/46664104/how-to-sign-in-kubernetes-dashboard

# delete pods
kubectl get deployments --all-namespaces
kubectl delete -n <namespace_name> deployment --all

# PLUGNIN TO DELETE ALL
helm plugin install https://github.com/astronomerio/helm-delete-all-plugin --version 0.0.2
helm delete-all


1. cluster/cluster_up.sh
2. helm/helm_setup.sh
3. helm/helm_install.sh
4. airflow/tunnel_web.sh