output "webapp_ips" {
  description = "Public IPs of compute-WebApp"
  value       = module.compute-WebApp[*].public_ip
  
}

output "db_ips" {
  description = "Public IPs of compute-DB"
  value       = module.compute-DB[*].public_ip
  
}
