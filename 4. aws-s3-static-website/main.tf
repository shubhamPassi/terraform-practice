terraform {
  required_providers {
    aws     = {
      source = "hashicorp/aws"
      version = "5.58.0"
    }
  }
}

provider "aws" {
  # Configuration options
  region = "us-east-1"
}

resource "aws_s3_bucket" "static_site_bucket" {
  bucket = "shubham-static-site"
}

resource "aws_s3_bucket_public_access_block" "static_site_public_access_block" {
  bucket = aws_s3_bucket.static_site_bucket.id

  block_public_acls       = false
  block_public_policy     = false
  ignore_public_acls      = false
  restrict_public_buckets = false
}

resource "aws_s3_bucket_policy" "static_site_allow_access_from_another_account" {
  bucket    = aws_s3_bucket.static_site_bucket.id
  policy    = jsonencode(
    {
        Version = "2012-10-17",
        Statement = [
            {
                Sid = "PublicReadGetObject",
                Effect = "Allow",
                Principal = "*",
                Action = "s3:GetObject",
                Resource = "arn:aws:s3:::shubham-static-site/*"
            }
        ]
    }
  )
}

resource "aws_s3_bucket_website_configuration" "static_site_configuration" {
  bucket = aws_s3_bucket.static_site_bucket.id

  index_document {
    suffix = "index.html"
  }
}

resource "aws_s3_object" "index_html" {
  bucket = aws_s3_bucket.static_site_bucket.bucket
  source = "./index.html"
  key = "index.html"
  content_type = "text/html"
}

resource "aws_s3_object" "styles_css" {
  bucket = aws_s3_bucket.static_site_bucket.bucket
  source = "./styles.css"
  key = "styles.css"
  content_type = "text/css"
}

output "site_url" {
  value = aws_s3_bucket_website_configuration.static_site_configuration.website_endpoint
}