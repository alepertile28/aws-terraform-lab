variable "ami" {}
variable "instance_type" {}
variable "instance_name" {}
variable "allowed_ips" {
  type = list(string)
}
variable "vpc_id" {}
variable "user_data" {
    default = null
}
