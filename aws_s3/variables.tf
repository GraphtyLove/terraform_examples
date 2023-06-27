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

variable "bucket_name" {
    description = "The name of the s3 bucket"
    type        = string
}

variable "days_til_archive" {
    description = "The number of days before the data is archived"
    type        = number
    default     = 90
}

variable "days_til_deletion" {
    description = "The number of days before the data is deleted"
    type        = number
    default     = 180
}