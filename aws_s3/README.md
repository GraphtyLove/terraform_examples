# Terraform AWS EC2 Instance

![Terraform Logo](https://upload.wikimedia.org/wikipedia/commons/thumb/0/04/Terraform_Logo.svg/1280px-Terraform_Logo.svg.png)

This project contains the Terraform configuration files to provision an Amazon EC2 instance on AWS.


## terraform.tfvars

Creat a `terraform.tfvars` file and define the desired variables.

Example file:

```terraform
# AWS
aws_region = "eu-west-1"
aws_access_key = "XXXXXXXXX"
aws_secret_key = "XXXXXXXXX"

# s3 bucket details
bucket_name = "becode_files"
days_til_archive = 90
days_til_delete = 180
```


## Usage`

Plan the changes to be made:

```bash
terraform plan
```

If everything is ok, apply the changes:

```bash
terraform apply
```


You can now see the resources' state with the command:

```bash
terraform state list
```

And see the details of the resources with the command:

```bash
terraform show
```


When you are done with your tests, **don't forget to delete the resources** with the command:

```bash
terraform destroy
```


## Documentation

You can read the complete official documentation here: 
[Terraforn aws ec2 documentation](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket).

# CLI AWS s3 Bucket
```bash
#!/bin/bash

# Define variables
BUCKET_NAME="my_bucket"
REGION="us-west-2"

# Create the bucket
aws s3api create-bucket --bucket $BUCKET_NAME --region $REGION --acl public-read

# Add CORS configuration
aws s3api put-bucket-cors --bucket $BUCKET_NAME --cors-configuration '{
  "CORSRules": [
    {
      "AllowedHeaders": ["*"],
      "AllowedMethods": ["PUT", "POST", "GET"],
      "AllowedOrigins": ["*"],
      "ExposeHeaders": ["ETag"],
      "MaxAgeSeconds": 3000
    }
  ]
}'

# Add bucket policy
aws s3api put-bucket-policy --bucket $BUCKET_NAME --policy '{
  "Version":"2012-10-17",
  "Statement":[
    {
      "Sid":"PublicReadGetObject",
      "Effect":"Allow",
      "Principal": "*",
      "Action":["s3:GetObject"],
      "Resource":["arn:aws:s3:::'$BUCKET_NAME'/*"]
    }
  ]
}'

# Add lifecycle configuration
aws s3api put-bucket-lifecycle-configuration --bucket $BUCKET_NAME --lifecycle-configuration '{
  "Rules": [
    {
      "ID": "glacier-and-delete",
      "Status": "Enabled",
      "Transitions": [
        {
          "Days": 90,
          "StorageClass": "GLACIER"
        }
      ],
      "Expiration": {
        "Days": 180
      }
    }
  ]
}'
```


Note that the AWS CLI commands are more imperative and less declarative compared to Terraform. This means you need to manage the dependencies (like making sure the security group is created before launching the instance) yourself. In Terraform, you declare your desired state, and Terraform figures out the dependencies and creates the resources in the correct order.

If you want to automate this process, you would need to parse the outputs of the commands and pass them as inputs to the next command. This is possible, but it's not as straightforward as with Terraform.