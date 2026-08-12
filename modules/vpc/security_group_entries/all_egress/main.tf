resource "aws_vpc_security_group_ingress_rule" "allow_ssh_ingress" {
  security_group_id = var.security_group_id
  ip_protocol = "tcp"

  from_port = 22
  to_port = 22
  cidr_ipv4 = var.cidr_ipv4
}