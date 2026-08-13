# resource "aws_security_group" "main_sg" {
#   name = "${var.vpc_name}-main_sg"
#   description = "Allow SSH"
#   vpc_id = module.vpc.vpc_id
# }

# module "allow_ssh_ingress" {
#   source = "../security_group_entries/ssh_ingress"

#   security_group_id = aws_security_group.main_sg.id
#   cidr_ipv4 = "0.0.0.0/0"
# }

# module "allow_all_egress" {
#   source = "../security_group_entries/all_egress"

#   security_group_id = aws_security_group.main_sg.id
# }