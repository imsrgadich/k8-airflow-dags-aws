## Intro
This repository is for recreating the infrastructure  
for my talk on airlfow on kubernetes + spark on EMR 

It contains an example DAG and task, as well as helpful scripts to build up the pipeline with kubernetes.

It's meant to illustrate the ease of setting up a MVP data pipeline, and should definitely be refined before being used in production.

The repos we'll be working with:

[kube-airflow](https://github.com/mumoshu/kube-airflow)   
[docker-airflow](https://github.com/puckel/docker-airflow)  
[airflow-dags](https://github.com/popoaq/airflow-dags) (this repo)

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

## Get Started

Follow this tutorial to spin up a k8s cluster
https://medium.com/containermind/how-to-create-a-kubernetes-cluster-on-aws-in-few-minutes-89dda10354f4

    git clone https://github.com/popoaq/airflow-dags.git
    git clone https://github.com/popoaq/kube-airflow.git
    git clone https://github.com/popoaq/docker-airflow.git
    
    
    
    
    
Steps to replicating the airflow + kubernetes + spark + emr project

