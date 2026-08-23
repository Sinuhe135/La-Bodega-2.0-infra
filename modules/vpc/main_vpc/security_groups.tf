resource "aws_security_group" "bastion_sg" {
  name = "${var.vpc_name}-bastion-sg"
  description = "Allow SSH ingress"
  vpc_id = module.vpc.vpc_id
}

resource "aws_vpc_security_group_egress_rule" "bastion_allow_all_egress" {
  security_group_id = aws_security_group.bastion_sg.id
  ip_protocol = "-1"

  cidr_ipv4 = "0.0.0.0/0"
}

resource "aws_vpc_security_group_ingress_rule" "bastion_allow_ssh_ingress" {
  security_group_id = aws_security_group.bastion_sg.id
  ip_protocol = "tcp"

  from_port = 22
  to_port = 22
  cidr_ipv4 = "0.0.0.0/0"
}