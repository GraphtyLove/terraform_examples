variable "aws_region" {
  description = "The region where AWS operations will take place. Examples are us-east-1, us-west-2, etc."
  type        = string
  default     = "eu-west-1"
}

variable "aws_access_key" {
  description = "The AWS access key. It must be provided, but it can also be sourced from the AWS_ACCESS_KEY_ID environment variable."
  type        = string
}

variable "aws_secret_key" {
  description = "The AWS secret key. It must be provided, but it can also be sourced from the AWS_SECRET_ACCESS_KEY environment variable."
  type        = string
}


variable "ec2_instance_type" {
    description = "The instance type to be used for the EC2. This will determine the VM's specs."
    type = string
    default = "t3.medium"
}

variable "disk_space_in_gb" {
  description = "How much disk space in GB to allocate for the EC2 instance."
  type        = number
  default     = 50
}