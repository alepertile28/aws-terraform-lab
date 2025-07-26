provider "aws" {
  region = var.aws_region
}

terraform {
  backend "s3" {
    bucket = "alexandre-terraform-state-bucket"
    key = "dev/terraform.tfstate"
    region = "us-east-1"
    dynamodb_table = "terraform-locks"
    encrypt = true
  }
}

data "aws_vpc" "default" {
  default = true
}

module "my_ec2" {
  source            = "./modules/ec2"
  ami               = "ami-0c101f26f147fa7fd"
  instance_type     = "t3.micro"
  instance_name     = "free-tier-ec2"
  security_group_id = module.security_group.id
  user_data         = file("${path.module}/modules/ec2/userdata.sh")
}

module "security_group" {
  source               = "./modules/security_group"
  name                 = "main_sg"
  description          = "Allow SSH and HTTPS traffic"
  vpc_id               = data.aws_vpc.default.id
  allowed_cidrs_blocks = ["177.159.125.24/29", "200.250.150.176/29", "179.105.225.192/32"]

}