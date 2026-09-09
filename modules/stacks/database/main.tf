module "rds" {
  source = "../../services/rds"

  vpc_remote_state_bucket = "labodega-state"
  vpc_remote_state_key    = var.vpc_remote_state_key

  identifier = var.identifier

  db_name     = var.db_name
  db_username = var.db_username
  db_password = var.db_password
}
