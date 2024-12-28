# Provider Configuration
provider "aws" {
  region     = "ap-southeast-1"
}

# Security Group
resource "aws_security_group" "baldaud_sg" {
  name        = "default-vpc-security-group"
  description = "Allow SSH and HTTP access"

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
    description = "Allow SSH access from anywhere"
  }

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
    description = "Allow HTTP access from anywhere"
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
    description = "Allow all outbound traffic"
  }

  tags = {
    Name = "DefaultVPCSecurityGroup"
  }
}

# First EC2 Instance
resource "aws_instance" "baldaudEC2_1" {
  ami           = "ami-06650ca7ed78ff6fa" 
  instance_type = "t2.micro"
  key_name      = "baldaud" 

  vpc_security_group_ids = [aws_security_group.baldaud_sg.id]

  ebs_block_device {
    device_name = "/dev/xvdf" 
    volume_size = 10
    volume_type = "gp2"
  }

  tags = {
    Name = "Terraform-EC2-Instance-1"
  }
}

# Second EC2 Instance
resource "aws_instance" "baldaudEC2_2" {
  ami           = "ami-06650ca7ed78ff6fa" 
  instance_type = "t2.micro"
  key_name      = "baldaud" 

  vpc_security_group_ids = [aws_security_group.baldaud_sg.id]

  ebs_block_device {
    device_name = "/dev/xvdf" 
    volume_size = 10
    volume_type = "gp2"
  }

  tags = {
    Name = "Terraform-EC2-Instance-2"
  }
}