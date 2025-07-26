variable "ami" {}
variable "instance_type" {}
variable "instance_name" {}
variable "user_data" {
    description = "value of user_data script"
    type = string
    default = null
}
variable "security_group_id" {
  description = "ID of the security group to associate with the EC2 instance"
  type        = string
  default     = null
  
}
