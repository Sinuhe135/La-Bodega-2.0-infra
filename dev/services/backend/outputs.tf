output "instance_hostname_1" {
  description = "Private DNS name of the EC2 instance."
  value       = module.backend.instance_hostname
} 

output "instance_hostname_2" {
  description = "Private DNS name of the EC2 instance."
  value       = module.backend2.instance_hostname
} 