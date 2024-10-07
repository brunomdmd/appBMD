# Security Group
resource "aws_security_group" "allow_http_https_ssh" {
  vpc_id = aws_vpc.vpc01.id
  tags = {
    Name = "SG-PRD-WEB-SSH"
  }

  ingress {
    description = "ALLOW-HTTP"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "ALLOW-HTTPS"
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}