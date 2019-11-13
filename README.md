# Introduction
This repository is for creating the Big Data pipeline infrastructure of Airflow on Kubernetes using the AWS's EMR.

This repository contains a DAG example with three simple tasks, as well as helpful scripts to build up the pipeline with kubernetes.

The repos we'll be working with:

[kube-airflow](https://github.com/mumoshu/kube-airflow)   
[docker-airflow](https://github.com/puckel/docker-airflow)  

This repository will help in creating the pipeline from scratch. First, we look at installing the necessary applications for running the scripts.

# Installation instructions for MacOS

#### AWS-CLI
AWS command line interface (CLI) tools are used for interacting with the AWS's services.

```
curl "https://s3.amazonaws.com/aws-cli/awscli-bundle.zip" -o "awscli-bundle.zip"
unzip awscli-bundle.zip
sudo ./awscli-bundle/install -i /usr/local/aws -b /usr/local/bin/aws
```

#### KOPS
Kubernetes operations (KOPS) is an official Kubernetes project for managing production-grade Kubernetes clusters. It has commands for creating clusters, updating their settings, and applying changes. 

`brew update && brew install kops`

#### KUBECTL
Kubectl is command line interface for managing the Kubernetes clusters.

`brew install kubectl`

#### Python environment
We use conda for creating the python environment. Run the following command.

```
conda create -n airflow-kube python==3.7
conda activate airflow-kube
conda install -c conda-forge airflow
```

# Setting up the data pipeline infrastructure

#### AWS
For setting up the data pipeline, first we need to create an account in AWS. Next, we need to create user with the following accesses. Make a note of the `Access Key` and `Secret Key`.  

* AmazonEC2FullAccess
* IAMFullAccess
* AmazonEC2ContainerRegistryFullAccess
* AmazonS3FullAccess
* AWSElasticBeanstalkFullAccess
* AmazonVPCFullAccess
* AmazonRoute53FullAccess

Next, we need to configure the local AWS. For that you will need to select a [AWS region](https://docs.aws.amazon.com/AmazonRDS/latest/UserGuide/Concepts.RegionsAndAvailabilityZones.html). Next, run the following command.

```
aws configure
```

Then you need to add the access key and it corresponding secret key for the user. Then give the AWS region and the format as `json`.

#### S3 bucket
Next, we need to create the S3 bucket for storing the state of the Kubernetes cluster. Run the following

```
aws s3api create-bucket --bucket kops-state-store-4 --region eu-central-1 --create-bucket-configuration LocationConstraint=eu-central-1
aws s3api put-bucket-versioning --bucket kops-state-store --versioning-configuration Status=Enabled
```

#### Kubernetes cluster
First, you need to set the environment variables.

```
export KOPS_CLUSTER_NAME=srikanth.k8s.local
export KOPS_STATE_STORE=s3://kops-state-store
export AWS_REGION=eu-central-1
```

Next, run the following for creating the cluster. This will update S3 bucket with the cluster configurations. This will also turn on the EC2 instances for the cluster. Here we are using on master and two slave nodes.
You can validate it by checking in [AWS console](console.aws.amazon.com). 

```
./scripts/cluster/cluster_up.sh
```

The script will also setup the Kubernetes dashboard and use the printed token for logging into it. 

Next, run the following to deploy the airflow on the cluster.

```
./scripts/helm/helm_setup.sh
./scripts/helm/helm_install.sh
```
This get the Airflow running. When you click on `PODS` in Kubernetes dashboard you will see them active and running.

In case you make any changes to the cluster, you can use `helm_upgrade` and next `helm_install` make the changes to the cluster.

Next, we need to tunnel into the cluster, to open the Airflow dashboard.

```
./scripts/airflow/tunnel_web.sh
```

You will be able to open the dashboard using `localhost:8080`





 


# Misc commands

### To get the availability zones 

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

## AWS local configuration file

`vi  /Users/imsrgadich/.aws/config`

## Aditional Tutorials 
https://pattern-match.com/blog/2019/01/30/k8s-tutorial-part01-setup-on-aws/

    
    

