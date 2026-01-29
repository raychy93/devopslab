variable "aws_region" {
  description = "AWS region to create resources in"
  type        = string
  default     = "us-east-1"
}

variable "instance_type" {
  description = "EC2 size"
  type        = string
  default     = "t3.micro"
}

variable "key_name" {
  description = "Name of your EC2 Key Pair"
  type        = string
}
