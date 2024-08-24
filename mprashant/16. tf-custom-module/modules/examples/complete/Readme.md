# This is the complete configuration to work with this module.

## Usage
```
provider "aws" {
  region = "us-east-1"
}

module "vpc-module" {
  source = "./modules/vpc"

  vpc_config = {
    cidr_block_vpc = "10.0.0.0/16"
    name = "shubham-vpc"
  }

  subnet_config = {
    shubham-subnet-private = {
      cidr_block_subnet = "10.0.0.0/24"
      az = "us-east-1a"
    }
  
    shubham-subnet-public-1 = {
      cidr_block_subnet = "10.0.1.0/24"
      az = "us-east-1b"
      public = true
    }

    shubham-subnet-public-2 = {
      cidr_block_subnet = "10.0.2.0/24"
      az = "us-east-1b"
      public = true
    }
  }
}
```