# Output com DNS do LB
output "lb_dns_name" {
  value = aws_lb.main.dns_name
}
