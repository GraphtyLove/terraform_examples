# Fetch the latest amazon_linux AMI (server image)
# This is to ensure we get the latest OS
data "aws_ami" "amazon_linux_2" {
  most_recent = true

  filter {
    name   = "name"
    values = ["amzn2-ami-hvm-*-gp2"]
  }

  filter {
    name   = "architecture"
    values = ["x86_64"]
  }

  owners = ["amazon"] # This is the Amazon account ID
}