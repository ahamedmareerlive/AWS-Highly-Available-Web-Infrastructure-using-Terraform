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
