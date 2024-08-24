terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
      version = "5.58.0"
    }
  }
}

provider "aws" {
  # Configuration options
  region = var.region
}

resource "aws_instance" "myserver" {
  ami = var.ami
  instance_type = "t2.micro"

  tags = {
    Name = "webserver"
  }
}