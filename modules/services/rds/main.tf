resource "aws_db_instance" "default" {
  engine               = "mysql"
  engine_version       = "8.4.8"

  instance_class       = "db.t4g.micro"
  allocated_storage    = 10
  max_allocated_storage = 100

  db_name              = var.db_name
  username             = var.db_username
  password             = var.db_password

  #vpc stuff

    multi_az                    = false
#   parameter_group_name = "default.mysql8.0" check this
  skip_final_snapshot  = true
}