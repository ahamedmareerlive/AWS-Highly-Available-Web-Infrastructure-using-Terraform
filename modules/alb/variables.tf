variable "vpc_id" {
  description = "VPC ID where ALB will be created"
  type        = string
}

variable "public_subnet_ids" {
  description = "List of public subnet IDs for ALB"
  type        = list(string)
}

variable "target_group_port" {
  description = "Port on which the target group receives traffic"
  type        = number
  default     = 8000
}

variable "alb_name" {
  description = "ALB name"
  type        = string
  default     = "my-alb"
}

variable "asg_name" {
  description = "Auto Scaling Group name to attach to the target group"
  type        = string
}
