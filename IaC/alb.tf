# Load Balancer
resource "aws_lb" "main" {
  name               = "LB-PRD-BMD"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [aws_security_group.allow_http_https_ssh.id]
  subnets            = [aws_subnet.subnet01.id, aws_subnet.subnet02.id]

  tags = {
    Name = "LB-PRD-BMD"
  }
}

# Target Group para o LB
resource "aws_lb_target_group" "TG-PRD-BMD" {
  name        = "TG-PRD-BMD"
  port        = 80
  protocol    = "HTTP"
  vpc_id      = aws_vpc.vpc01.id
  target_type = "ip"

  health_check {
    path                = "/"
    interval            = 30
    timeout             = 5
    healthy_threshold   = 5
    unhealthy_threshold = 5
  }

  tags = {
    Name = "TG-PRD-BMD"
  }
}

# Listener para o ALB
resource "aws_lb_listener" "http" {
  load_balancer_arn = aws_lb.main.arn
  port              = 80
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.TG-PRD-BMD.arn
  }
}
