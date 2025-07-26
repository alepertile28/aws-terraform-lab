output "instance_id" {
  value = aws_instance.ec2-free-tier.id
}

output "public_ip" {
  value = aws_instance.ec2-free-tier.public_ip
}

output "private_ip" {
  value = aws_instance.ec2-free-tier.private_ip
}

output "private_key_pem" {
  value     = tls_private_key.ssh_key.private_key_pem
  sensitive = true
}