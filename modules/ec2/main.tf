resource "tls_private_key" "ssh_key" {
  algorithm = "RSA"
  rsa_bits  = 4096
}

resource "aws_key_pair" "generated_key" {
  key_name = "tf-key-free-tier"
  public_key = tls_private_key.ssh_key.public_key_openssh
}

resource "local_file" "private_key" {
    content = tls_private_key.ssh_key.private_key_pem
    filename = "${path.module}tf-key.pem"
    file_permission = "0600"
}

resource "aws_instance" "ec2-free-tier" {
  ami = var.ami
  instance_type = var.instance_type
  associate_public_ip_address = true
  user_data = var.user_data
  key_name = aws_key_pair.generated_key.key_name
  vpc_security_group_ids = [var.security_group_id] 
  
  tags = {
    Name = var.instance_name
  }
}