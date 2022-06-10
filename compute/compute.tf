#ami data
data "aws_ami" "linux" {
  most_recent = true

  filter {
    name   = "name"
    values = ["amzn2-ami-hvm-*-x86_64-gp2"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  owners = ["amazon"]
}

#Create autoscaling group launch template
resource "aws_launch_template" "web" {
  name_prefix            = "web"
  image_id               = data.aws_ami.linux.id
  instance_type          = var.web_instance_type
  vpc_security_group_ids = [var.vpc_security_group_ids]
  user_data              = filebase64("install_apache.sh")

  tags = {
    Name = "web-server"
  }
}

#create autoscaling group
resource "aws_autoscaling_group" "web" {
  name                = "web"
  vpc_zone_identifier = tolist(var.public_subnet)
  min_size            = 2
  max_size            = 3
  desired_capacity    = 2

  launch_template {
    id      = aws_launch_template.web.id
    version = "$Latest"
  }
  
  lifecycle {
    ignore_changes = [ target_group_arns ]
  }
}

