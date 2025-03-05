# Installing AWS from hashicorp
terraform {
    required_providers {
        aws = {
            source = "hashicorp/aws"
            version = "~> 5.88.0"
        }
    }
    required_version = ">=1.2.0"
}

# Fetching latest AMI ID from AWS because if we hardcode, that image may become outdated
data "aws_ami" "aws_linux" {
    most_recent = true  # Get the latest image available AMI

    # It tells Terraform to look for an AMI with a name that matches a specific pattern.
    filter {
      name   = "name"
      values = ["amzn2-ami-kernel-5.10-hvm-*-x86_64-gp2"]
    }

    # It filters AMIs based on their virtualization type. "hvm" (Hardware Virtual Machine) is required for modern EC2 instances.
    filter {
      name   = "virtualization-type"
      values = ["hvm"]
    }

}

# Creation of AWS instance
resource "aws_instance" "my_instance" {
    # We can even hardcode value from aws but this is future proof
    ami = data.aws_ami.aws_linux.id    # fetching ami from above filter block
    instance_type = "t2.micro"
    key_name = "Ansible-key"
    tags = {
        Name = "${var.name}-server"
    }
}

# Creation of S3 Bucket
resource "aws_s3_bucket" "my_bucket" {
    bucket = "devops_project_bucket-23"
    tags = {
        Name = "devops_project_bucket-23"
    }
}
