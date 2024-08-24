terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
      version = "5.61.0"
    }

    random = {
      source = "hashicorp/random"
      version = "3.6.2"
    }
  }
}


provider "aws" {
  region = "us-east-1"
}

resource "random_id" "rand_id" {
  byte_length = 8
}

resource "aws_s3_bucket" "s3_bucket" {
  bucket = "shubham-bucket-${terraform.workspace}-${random_id.rand_id.hex}"
}