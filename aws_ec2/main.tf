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
# Create a key-pair of credentials to be able to connect the server via ssh
# This should be generated before hand with the command: 
# ssh-keygen -t rsa -b 4096 -f my_keypair
# DO NOT COMMIT THIS FILE TO GITHUB!
resource "aws_key_pair" "my_keypair" {
  key_name   = "my_keypair"
  public_key = file("${path.module}/my_keypair.pub")
}

# Create a security group that allow ssh to your server
resource "aws_security_group" "allow_ssh" {
  name        = "allow_ssh"
  description = "Allow SSH inbound traffic"

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}


# "aws_instance" is the ec2 module
# test_ec2_server_becode is the name of the resource. 
# It can be anything, use something that makes sens for your project.
resource "aws_instance" "test_ec2_server_becode" {
  # Get the AMI from the data.tf
  ami           = data.aws_ami.amazon_linux_2.id
  # Get the instance type from variable so it can be changed
  instance_type = var.ec2_instance_type
  # Define your keypair to be used on this server
  key_name = aws_key_pair.my_keypair.key_name
  # Add the security group we created to the ec2
  vpc_security_group_ids = [aws_security_group.allow_ssh.id]


  # Tags are used to recognize you resources
  tags = {
    contact = "maxim@becode.org"
    project = "learning_terraform"
  }
}

# Assign a public ip to your server to be able to ssh into it
resource "aws_eip" "ec2_public_ip" {
  vpc      = true
  instance = aws_instance.test_ec2_server_becode.id
}