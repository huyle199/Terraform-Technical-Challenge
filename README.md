# Terraform-Technical-Challenge
This repo is a collection of configuration for deploying AWS. It include: 1 VPC, 4 Subnets, 1 Redhat EC2 instance, 1 Auto scaling group, 1 Application load balance, Security Groups, Internet Gateway, Route table, 2 S3 buckets with lifecycle rules, iam profile with 2 iam roles.

Technical Diagram:
![architecture_diagram drawio](https://github.com/huyle199/Terraform-Technical-Challenge/assets/86170240/507df2ba-f0f6-4452-84b3-fc2df23811ff)

Workflow:
![terraform_ (1)](https://github.com/huyle199/Terraform-Technical-Challenge/assets/86170240/f0983df8-ec61-49cb-abdf-81d1315c2f53)


asg.tf: This file will define the launch template and autoscaling group
ec2.tf: This file will define the standalone redhat ec2
