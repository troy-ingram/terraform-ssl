# --- networking/outputs.tf ---

output "vpc_id" {
  value = aws_vpc.my-vpc.id
}

output "web_sg" {
  value = aws_security_group.web-sg.id
}

output "public_subnet" {
  value = aws_subnet.web-subnet[*].id
}

output "private_subnet" {
  value = aws_subnet.application-subnet[*].id
}

output "vpc_security_group_ids" {
  value = aws_security_group.web-sg.id
}

output "external-elb" {
  value = aws_lb.external-elb
}

output "lb_dns_name" {
  #   count       = length(var.public_cidrs)
  description = "The DNS name of the load balancer"
  value       = aws_lb.external-elb.dns_name
}