# SECURITY GROUP
resource "aws_security_group" "this" {
  name   = "asg-sg"
  vpc_id = var.vpc_id

  dynamic "ingress" {
    for_each = var.allowed_ports
    content {
      from_port   = ingress.value
      to_port     = ingress.value
      protocol    = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
    }
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

# LAUNCH TEMPLATE  ✅ REQUIRED
resource "aws_launch_template" "this" {
  name_prefix   = "asg-lt-"
  image_id      = var.ami_id
  instance_type = var.instance_type
  key_name         = var.key_name            # <-- Add this line

  vpc_security_group_ids = [aws_security_group.this.id]

  tag_specifications {
    resource_type = "instance"
    tags = {
      Name = "asg-instance"
    }
  }
}

# AUTO SCALING GROUP
resource "aws_autoscaling_group" "this" {
  desired_capacity = var.desired_capacity
  min_size         = var.min_size
  max_size         = var.max_size
 

  vpc_zone_identifier = var.private_subnet_ids

  launch_template {
    id      = aws_launch_template.this.id
    version = "$Latest"
  }

  health_check_type = "EC2"
}
