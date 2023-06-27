# ========== PROVIDERS ==========
# Define the providers (AWS in this case)
terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 3.0"
    }
  }
}

# Provider configuration
provider "aws" {
  region = var.aws_region
  access_key = var.aws_access_key
  secret_key = var.aws_secret_key
}

resource "aws_s3_bucket" "bucket" {
  bucket = var.bucket_name
  # Allow public read (anyone can download your files)
  acl    = "public-read"

  # Allow file download from anywhere (instead of specific domains/ip whitelist)
  cors_rule {
    allowed_headers = ["*"]
    allowed_methods = ["PUT","POST"]
    allowed_origins = ["*"]
    expose_headers  = ["ETag"]
    max_age_seconds = 3000
  }

  # Defile the data lifecycle
  lifecycle_rule {
    id      = "glacier-and-delete"
    status  = "Enabled"

    # Change the storage class to GLACIER after X days
    transition {
      days          = var.days_til_archive
      storage_class = "GLACIER"
    }
    # Delete the data after X days
    expiration {
      days = var.days_til_deletion
    }
  }
}

# Create a policy to allow everyone to download the data
resource "aws_s3_bucket_policy" "bucket_policy" {
  bucket = aws_s3_bucket.bucket.id

  policy = <<POLICY
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Sid": "PublicReadGetObject",
      "Effect": "Allow",
      "Principal": "*",
      "Action": ["s3:GetObject"],
      "Resource": ["arn:aws:s3:::${aws_s3_bucket.bucket.id}/*"]
    }
  ]
}
POLICY
}
