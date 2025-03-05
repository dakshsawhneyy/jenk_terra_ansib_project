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
    ami = data.aws_ami.aws_linux.id    # fetching ami from above filter block
    instance_type = "t2.micro"
    key_name = "Ansible-key"
    tags = {
        Name = "${var.name}-server"
    }
}
