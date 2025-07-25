variable "name" {
  description = "main_sg"
  type        = string
}

variable "description" {
  description = "Allow SSH and HTTPS traffic"
  type        = string
}

variable "vpc_id" {
  description = "VPC ID where the security group will be created"
  type        = string
}

variable "allowed_cidrs_blocks" {}
