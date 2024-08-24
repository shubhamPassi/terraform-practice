# terraform-aws-vpc 

## Overview module/vpc
This Terraform module creates an AWS VPC with a given CIDR block. It also creates multiple subnets (public and private), and for public subnets, it sets up an Internet Gateway (IGW) and appropriate route tables. 

## Features 
— Creates a VPC with a specified CIDR block 
- Creates public and private subnets 
- Creates an Internet Gateway (IGW) for public subnets 
- Sets up route tables for public subnets 

## Usage 
```
module "vpc-module" {
  source = "./modules/vpc"

  vpc_config = {
    cidr_block_vpc = "10.0.0.0/16"
    name = "< Your VPC name >"
  }

  subnet_config = {  
    shubham-subnet-public-1 = {
      cidr_block_subnet = "10.0.1.0/24"
      az = "us-east-1b"
      # To set the subnet as public, default is private
      public = true
    }

    shubham-subnet-private = {
      cidr_block_subnet = "10.0.0.0/24"
      az = "us-east-1a"
    }
  }
}
```