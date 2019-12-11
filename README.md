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
- 
