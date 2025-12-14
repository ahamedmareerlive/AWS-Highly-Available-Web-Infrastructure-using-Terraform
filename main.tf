module "vpc" {
  source = "./modules/vpc"

  vpc_cidr                = var.vpc_cidr
  vpc_name                = var.vpc_name
  igw_name                = var.igw_name

  public_route_table_name  = var.public_route_table_name

  public_subnets           = var.public_subnets
  private_subnets          = var.private_subnets
  private_route_table_names = var.private_route_table_names

  nat_eip_name = var.nat_eip_name
  nat_gw_name  = var.nat_gw_name
}

module "asg" {
  source = "./modules/asg"

  vpc_id             = module.vpc.vpc_id
  private_subnet_ids = values(module.vpc.private_subnet_ids)

  ami_id        = var.ami_id          # ✅ FIX
  instance_type = var.instance_type

  desired_capacity = var.asg_desired_capacity
  min_size         = var.asg_min_size
  max_size         = var.asg_max_size

  allowed_ports = var.allowed_ports
  key_name           = var.key_name 
    
}


module "alb" {
  source = "./modules/alb"

  vpc_id           = module.vpc.vpc_id
  public_subnet_ids = values(module.vpc.public_subnet_ids)

  target_group_port = 8000
  alb_name          = var.alb_name
  asg_name          = module.asg.asg_name   # attach ASG to ALB
}
