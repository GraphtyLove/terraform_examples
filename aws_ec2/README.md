# Terraform AWS EC2 Instance

![Terraform Logo](https://upload.wikimedia.org/wikipedia/commons/thumb/0/04/Terraform_Logo.svg/1280px-Terraform_Logo.svg.png)

This project contains the Terraform configuration files to provision an Amazon EC2 instance on AWS.


## terraform.tfvars

Creat a `terraform.tfvars` file and define the desired variables.

Example file:

```terraform
# AWS
region = "eu-west-1"
aws_access_key = "XXXXXXXXX"
aws_secret_key = "XXXXXXXXX"

# ec2 details
ec2_instance_type = "t2.micro"
```


## Usage
Generate the key-pair to be used to connect to the instance:

```bash
ssh-keygen -t rsa -b 4096 -f my_keypair
```

Plan the changes to be made:

```bash
terraform plan
```

If everything is ok, apply the changes:

```bash
terraform apply
```

You should receive an input like this:
```
aws_key_pair.my_keypair: Creating...
aws_security_group.allow_ssh: Creating...
aws_key_pair.my_keypair: Creation complete after 1s [id=my_keypair]
aws_security_group.allow_ssh: Creation complete after 5s [id=sg-074438b2724096398]
aws_instance.test_ec2_server_becode: Creating...
aws_instance.test_ec2_server_becode: Creation complete after 34s [id=i-0f7fbdb62c8b0777c]
aws_eip.ec2_public_ip: Creating...
aws_eip.ec2_public_ip: Creation complete after 1s [id=eipalloc-08c46338a60e6b9f4]

Apply complete! Resources: 4 added, 0 changed, 0 destroyed.

Outputs:

ip_address = "XX.XX.X.XXX"
```

You can now see the resources' state with the command:

```bash
terraform state list
```

With an output like:

```
data.aws_ami.amazon_linux_2
aws_instance.test_ec2_server_becode
```

And see the details of the resources with the command:

```bash
terraform show
```

Finally, you can connect to your instance with the command:

```bash
# ec2-user is the default user for Amazon Linux 2 AMI
ssh -i my_keypair ec2-user@XX.XX.X.XXX
```

When you are done with your tests, **don't forget to delete the resources** with the command:

```bash
terraform destroy
```


## Documentation

You can read the complete official documentation here: 
[Terraforn aws ec2 documentation](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/instance).

# CLI AWS EC2 Instance

![AWS cli](https://miro.medium.com/v2/resize:fit:1017/0*tHezTGVhyqoXDtKu.png)

If we wanted to do the same with aws cli, we would have to do the following:

## Create the VPC
```bash
aws ec2 create-vpc --cidr-block 10.0.0.0/16
```
In this command, `--cidr-block 10.0.0.0/16` specifies the **IPv4 network range** for the VPC in CIDR notation. This example creates a VPC with a size `/16` CIDR *(10.0.0.0 - 10.0.255.255)*.

This command will return a JSON response that includes the ID of the new VPC (in the Vpc -> VpcId field), among other information.

You can then use this VPC ID in the following `create-security-group` command.

## Create a security group

```bash
# Create a security group
aws ec2 create-security-group --group-name allow_ssh --description "Security group for SSH access" --vpc-id vpc-xxxxxxxx
# Add a rule to the security group
aws ec2 authorize-security-group-ingress --group-id sg-xxxxxxxx --protocol tcp --port 22 --cidr 0.0.0.0/0
```


## Create an instance

```bash
aws ec2 run-instances --image-id ami-xxxxxxxx --count 1 --instance-type t2.micro --key-name my_keypair --security-group-ids sg-xxxxxxxx
```

## Create an elastic IP
This command will output the allocation ID of the new Elastic IP address.
```bash
aws ec2 allocate-address --domain vpc
```
Associate the Elastic IP address with the instance:
```bash
aws ec2 associate-address --instance-id i-xxxxxxxx --allocation-id eipalloc-xxxxxxxx
```

Note that the AWS CLI commands are more imperative and less declarative compared to Terraform. This means you need to manage the dependencies (like making sure the security group is created before launching the instance) yourself. In Terraform, you declare your desired state, and Terraform figures out the dependencies and creates the resources in the correct order.

If you want to automate this process, you would need to parse the outputs of the commands and pass them as inputs to the next command. This is possible, but it's not as straightforward as with Terraform.