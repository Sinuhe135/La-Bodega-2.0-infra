output "database_name" {
  value       = aws_db_instance.rds.db_name
  description = "The database name"
}

output "username" {
  value       = aws_db_instance.rds.username
  description = "The master username"
}

output "port" {
  value       = aws_db_instance.rds.port
  description = "The database port"
}

output "endpoint" {
  value       = aws_db_instance.rds.address
  description = "The database endpoint"
}
