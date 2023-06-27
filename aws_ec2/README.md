# Terraform AWS EC2 Instance

![Terraform Logo](https://upload.wikimedia.org/wikipedia/commons/thumb/0/04/Terraform_Logo.svg/1280px-Terraform_Logo.svg.png)

This project contains the Terraform configuration files to provision an Amazon EC2 instance on AWS.

## Files

Below is a description of each file in the project:

1. `main.tf`: This file contains the main set of configuration for your Terraform project. In our case, it specifies the AWS provider and contains the configuration to create an EC2 instance.

2. `variables.tf`: This file is used for the declaration of variables that are used in the `main.tf` file. It contains the declarations for AWS region, access key, and secret key variables.

3. `terraform.tfvars`: This file is used to set the values for the variables declared in `variables.tf`. This file should not be committed to version control if it contains sensitive information like AWS access keys.

4. `data.tf`: This file contains the configuration to retrieve the latest Amazon Linux AMI ID for the specified AWS region.

5. `.terraform.lock.hcl`: This file is used by Terraform to track the provider versions used in the project. This is important to ensure that the project can be used consistently across different environments.

## How to Use

To use this project, follow these steps:

1. Clone the repository to your local machine.

2. Update the `terraform.tfvars` file with your AWS credentials and desired region.

3. Open a terminal and navigate to the directory containing the Terraform files.

4. Run `terraform init` to initialize your Terraform workspace.

5. Run `terraform plan` to see the changes that will be made.

6. Run `terraform apply` to apply the changes. You will be prompted to confirm that you want to make the changes.

7. ⚠️ ⚠️ ⚠️ When you're done with the resources, run `terraform destroy` to clean up. ⚠️ ⚠️ ⚠️

**Note:** Always double-check the changes during the `plan` step to ensure you are making the changes you intend, and always clean up your resources when you're done to avoid unnecessary AWS charges.
