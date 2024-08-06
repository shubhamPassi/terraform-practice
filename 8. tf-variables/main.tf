terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
      version = "5.59.0"
    }
  }
}

provider "aws" {
  region = "us-east-1"
}

resource "aws_instance" "myserver" {
  ami = "ami-04a81a99f5ec58529"
  instance_type = var.aws_instance_type

  root_block_device {
    delete_on_termination = true
    volume_size = var.ec2_config.vol_size
    volume_type = var.ec2_config.vol_type
  }

  tags = merge(var.additional_tags, {
    Name = "webserver"
  })
}