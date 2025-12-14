variable "vpc_cidr" {}
variable "vpc_name" {}
variable "igw_name" {}

variable "public_route_table_name" {}

variable "public_subnets" {
  type = map(object({
    cidr = string
    az   = string
    name = string
  }))
}

variable "private_subnets" {
  type = map(object({
    cidr = string
    az   = string
    name = string
  }))
}

variable "private_route_table_names" {
  type = map(string)
}

variable "nat_eip_name" {}
variable "nat_gw_name" {}

variable "asg_desired_capacity" {}
variable "asg_min_size" {}
variable "asg_max_size" {}

variable "instance_type" {}

variable "allowed_ports" {
  type = list(number)
}
variable "ami_id" {
  description = "AMI ID for ASG instances"
}
variable "key_name" {
  description = "EC2 Key Pair name"
  type        = string
}

variable "alb_name" {
  default = "my-alb"
}
