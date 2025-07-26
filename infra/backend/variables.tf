variable "region" {
  default = "us-east-1"
}

variable "bucket_name" {
  default = "alexandre-terraform-state-bucket"
}

variable "dynamodb_table_name" {
  default = "terraform-locks"
}
