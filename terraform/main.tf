provider "aws" {
  region = var.aws_region
}

# Fetch latest Amazon Linux 2023 AMI via SSM
data "aws_ssm_parameter" "al2023_ami" {
  name = "/aws/service/ami-amazon-linux-latest/al2023-ami-kernel-6.1-x86_64"
}

# Default VPC + subnets
data "aws_vpc" "default" {
  default = true
}

data "aws_subnets" "default_vpc_subnets" {
  filter {
    name   = "vpc-id"
    values = [data.aws_vpc.default.id]
  }
}

# Security group: SSH + HTTP
resource "aws_security_group" "lab_sg" {
  name        = "tf-lab-sg"
  description = "Allow SSH (22) and HTTP (80) for lab"
  vpc_id      = data.aws_vpc.default.id

  ingress {
    description = "SSH from anywhere"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "HTTP from anywhere (for nginx test)"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    description = "Allow all outbound"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = { Name = "tf-lab-sg" }
}

resource "aws_instance" "web" {
  ami           = data.aws_ssm_parameter.al2023_ami.value
  instance_type = var.instance_type
  subnet_id     = data.aws_subnets.default_vpc_subnets.ids[0]

  vpc_security_group_ids = [aws_security_group.lab_sg.id]
  key_name               = var.key_name

  tags = { Name = "terraform-ansible-lab" }
}
