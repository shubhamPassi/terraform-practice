terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
      version = "5.58.0"
    }
  }

  backend "s3" {
    bucket = "shubham-bucket-d93c40820ce108e1"
    key = "terraform.tfstate"
    region = "us-east-1"
    dynamodb_table  = "dynamodb-state-locking"
  }
}

provider "aws" {
  # Configuration options
  region = "us-east-1"
}


resource "aws_s3_bucket" "s3_bucket" {
  bucket = "shubham-bucket-a122"
}

resource "aws_s3_object" "s3_object" {
  bucket = aws_s3_bucket.s3_bucket.bucket
  key = "file2.txt"
  source = "./file2.txt"
}