# terraform-ssl

The purpose of this Terraform code is to attach an AWS ACM Certificate to an ALB to allow HTTPS traffic.

This Terraform code will create the following AWS resources in US-East-1:
1 Application Load Balancer
1 Autoscaling group with a min of 2 and max of 5 with an apache webserver
1 Custom VPC with 2 public subnets, 2 private subnets, public route table
1 ALB Security Group
1 Webserver Security Group



