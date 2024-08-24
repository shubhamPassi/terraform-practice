terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
      version = "5.58.0"
    }

    random = {
      source    = "hashicorp/random"
      version   = "3.6.2"
    }
  }

  backend "s3" {
    bucket          = "shubham-bucket-d93c40820ce108e1"
    key             = "terraform.tfstate"
    region          = "us-east-1"
    dynamodb_table  = "dynamodb-state-locking"
  }
}

provider "aws" {
  # Configuration options
  region    = "us-east-1"
}

resource "random_id" "rand_id" {
  byte_length   = 8
}

resource "aws_s3_bucket" "s3_bucket" {
  bucket    = "shubham-bucket-${random_id.rand_id.hex}"
}

resource "aws_s3_object" "s3_object" {
  bucket    = aws_s3_bucket.s3_bucket.bucket
  key       = "file.txt"
  source    = "./file1.txt"
}

output "rand_id" {
  value     = random_id.rand_id.hex
}