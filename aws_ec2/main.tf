# ========== PROVIDERS ==========
# Define the providers (AWS in this case)
terraform {
  required_providers {
    aws = {
      # Define from where we loof for the provider
      # From the official Ashicorp repo in this case.
      source = "hashicorp/aws"
      # Define the version of the provider to be used.
      version = "~> 3.0"
    }
  }
}

# Provider configuration
provider "aws" {
  region = "eu-west-1"
  access_key = var.aws_access_key
  secret_key = var.aws_secret_key
}


# ========== RESOURCES ==========
resource "aws_instance" "example" {
  # Get the AMI from the data.tf
  ami           = data.aws_ami.amazon_linux_2.id
  # Get the instance type from variable so it can be changed
  instance_type = var.ec2_instance_type

  tags = {
    contact = "maxim@becode.org"
    project = "learning_terraform"
  }
}