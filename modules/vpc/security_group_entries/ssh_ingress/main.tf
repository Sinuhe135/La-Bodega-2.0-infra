resource "aws_vpc_security_group_egress_rule" "allow_all_egress" {
  security_group_id = var.security_group_id
  ip_protocol = "-1"

  # cidr_ipv4 = var.cidr_ipv4
  # referenced_security_group_id = 
}