variable "vpc_id" {}

variable "private_subnet_ids" {
  type = list(string)
}

variable "ami_id" {}
variable "instance_type" {}

variable "desired_capacity" {}
variable "min_size" {}
variable "max_size" {}

variable "allowed_ports" {
  type = list(number)
}
variable "key_name" {
  description = "EC2 key pair name"
  type        = string
}
