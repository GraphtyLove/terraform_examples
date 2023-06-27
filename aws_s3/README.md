# Terraform AWS EC2 Instance

![Terraform Logo](https://upload.wikimedia.org/wikipedia/commons/thumb/0/04/Terraform_Logo.svg/1280px-Terraform_Logo.svg.png)

This project contains the Terraform configuration files to provision an Amazon s3 bucket on AWS.

We also want to change each object's **storage class to `GLACIER` after 3 month**. The files will be **deleted after 6 month**.

This allow us to minimize the costs. The files sould not be accessed after 3 month except in case of an audit. After 6 months, we don't need the files anymore.


## terraform.tfvars

Creat a `terraform.tfvars` file and define the desired variables.

Example file:

```terraform
# AWS
aws_region = "eu-west-1"
aws_access_key = "XXXXXXXXX"
aws_secret_key = "XXXXXXXXX"

# ec2 details
ec2_instance_type = "t2.micro"
```


## Usage
Generate the key-pair to be used to connect to the instance:



## Documentation

You can read the complete official documentation here: 
[Terraforn aws ec2 documentation](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/instance).

# CLI AWS EC2 Instance

![AWS cli](https://miro.medium.com/v2/resize:fit:1017/0*tHezTGVhyqoXDtKu.png)

If we wanted to do the same with aws cli, we would have to do the following:
