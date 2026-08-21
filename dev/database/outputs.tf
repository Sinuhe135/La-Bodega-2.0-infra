output "database_name" {
  value       = module.rds.database_name
  description = "The database name"
}

output "username" {
  value       = module.rds.username
  description = "The master username"
}

output "port" {
  value       = module.rds.port
  description = "The database port"
}

output "endpoint" {
  value       = module.rds.endpoint
  description = "The database endpoint"
}
