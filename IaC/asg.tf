# Launch Template
resource "aws_launch_template" "web_launch_template" {
  name_prefix   = "BMD-"
  image_id      = "ami-0866a3c8686eaeeba"
  instance_type = "t2.micro"
  key_name      = aws_key_pair.key.key_name
  vpc_security_group_ids = [aws_security_group.allow_http_https_ssh.id]
}


# ASG
resource "aws_autoscaling_group" "ASG-PRD-BMD" {
  desired_capacity    = 1
  max_size            = 3
  min_size            = 1
  vpc_zone_identifier = [aws_subnet.subnet01.id, aws_subnet.subnet02.id]
  launch_template {
    id      = aws_launch_template.web_launch_template.id
    version = "$Latest"
  }

  tag {
    key                 = "Name"
    value               = "WEB-BMD"
    propagate_at_launch = true
  }
}


# Threshold para o Scale (uso de CPU)
resource "aws_autoscaling_policy" "scale_up" {
  name                   = "scale-up"
  scaling_adjustment     = 1
  adjustment_type        = "ChangeInCapacity"
  cooldown               = 300
  autoscaling_group_name = aws_autoscaling_group.ASG-PRD-BMD.name
}

resource "aws_autoscaling_policy" "scale_down" {
  name                   = "scale-down"
  scaling_adjustment     = -1
  adjustment_type        = "ChangeInCapacity"
  cooldown               = 300
  autoscaling_group_name = aws_autoscaling_group.ASG-PRD-BMD.name
}

