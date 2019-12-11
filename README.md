# Docker

The Docker image is based in nginx:alpine and I only added the files of the static site.
- You can check the content of the image in the *app* folder.
- I published the docker image in docker hub with the id pureta/staticsite:firsttry to use with kubernetes in next steps. https://hub.docker.com/repository/docker/pureta/staticsite

# Kubernetes

The kubernetes service and deployment was tested in the local machine with minikube and work correctly.

# Terraform

Is my first time doing this kind of infrastructure, and by this reasons I was searching differents articles and examples, finally I decided follow the tutorial of https://www.esentri.com/building-a-kubernetes-cluster-on-aws-eks-using-terraform/
the reason to follow this tutorial was that provide an infrastructure scalable, have a good files organization in modules and the solution to manage the terraform state in a distribuited team.
I was very ambicius and finally I had troubles not expected, is almost done, I have to solve a network issue between the load balancer and the node.

The infrastructure schema proposed here is:

![infrastructure schema](https://www.esentri.com/wp-content/uploads/2019/02/articlepic_transparent.png)

## What resources are created

1. VPC
2. Internet Gateway (IGW)
3. Public and Private Subnets
4. Security Groups, Route Tables and Route Table Associations
5. IAM roles, instance profiles and policies
6. An EKS Cluster
7. Autoscaling group and Launch Configuration
8. Worker Nodes in a private Subnet
9. The ConfigMap required to register Nodes with EKS
10. KUBECONFIG file to authenticate kubectl using the `aws eks get-token` command. needs awscli version `1.16.156 >`

## Configuration

You can configure you config with the following input variables:


| Name                      | Description                        | 
| ------------------------- | ---------------------------------- 
| `aws-region`              | The AWS Region to deploy EKS       | 
| `aws_access_key`          | The account identification key used by your Terraform client             | 
| `aws_secret_key`          | The secret key used by your terraform client to access AWS  | 
| `subnet_count`            | The number of subnets we want to create per type to ensure high availability      | 
| `accessing_computer_ip`   | IP of the computer to be allowed to connect to EKS master and nodes  | 
| `keypair-name`            | Name of the keypair declared in AWS IAM, used to connect into your instances via SSH  | 
| `hosted_zone_id`          | ID of the hosted Zone created in Route53 before Terraform deployment  | 
| `hosted_zone_url`         | URL of the hosted Zone created in Route53 before Terraform deployment  | 

## How to use this example

```bash
git clone git@github.com:smuriana/openPaydTest.git
cd openPaydTest
```


### Terraform

You need to run the following commands to create the resources with Terraform:

```bash
terraform init
terraform plan
terraform apply
```

### Setup kubectl

Setup your `KUBECONFIG`

```bash
terraform output kubeconfig > ~/.kube/eks-cluster
export KUBECONFIG=~/.kube/eks-cluster
```

### Authorize worker nodes

Get the config from terraform output, and save it to a yaml file:

```bash
terraform output config-map > config-map-aws-auth.yaml
```

Configure aws cli with a user account having appropriate access and apply the config map to EKS cluster:

```bash
kubectl apply -f config-map-aws-auth.yaml
```

You can verify the worker nodes are joining the cluster

```bash
kubectl get nodes --watch
```

### Apply service and deployment

```bash
kubectl apply -f kubernetes/frontend-service.yaml
```

```bash
kubectl apply -f kubernetes/frontend-deployment.yaml
```

### Cleaning up

You can destroy this cluster entirely by running:

```bash
terraform plan -destroy
terraform destroy  --force
```


## ToDo list
- Fix network issue between the load balancer and the node.
- Fix SSL certificate issue
- Set cluster name as variable
- Create terraform file to release kubernetes app
- Change cat image format to png
- Provide the image by CDN 
