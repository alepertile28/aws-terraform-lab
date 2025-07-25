variable "ami" {}
variable "instance_type" {}
variable "instance_name" {}
variable "user_data" {
    default = null
}
variable "security_group_id" {
  description = "ID of the security group to associate with the EC2 instance"
  type        = string
  default     = null
  
}
