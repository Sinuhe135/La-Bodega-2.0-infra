data "terraform_remote_state" "vpc" {
  backend = "s3"
  config = {
    region = "us-west-2"
    bucket = var.vpc_remote_state_bucket
    key = var.vpc_remote_state_key
  }
}


resource "aws_db_instance" "rds" {
  engine               = "mysql"
  engine_version       = "8.4.8"

  instance_class       = "db.t4g.micro"
  allocated_storage    = 10
  max_allocated_storage = 100

  db_name              = var.db_name
  username             = var.db_username
  password             = var.db_password

  db_subnet_group_name = aws_db_subnet_group.rds_subnet_group.name

  identifier           = "${var.identifier}-db"
  multi_az                    = false
  skip_final_snapshot  = true
}

resource "aws_db_subnet_group" "rds_subnet_group" {
  name       = "${var.identifier}-subnet-group"
  subnet_ids = [
    data.terraform_remote_state.vpc.outputs.vpc_private_subnets[0], 
    data.terraform_remote_state.vpc.outputs.vpc_private_subnets[1]
  ]

  tags = {
    Name = "${var.identifier}-rds-subnet-group"
  }
}