output "id" {
  description = "Resource ID of the Public IP."
  value       = azurerm_public_ip.this.id
}

output "name" {
  description = "Name of the Public IP."
  value       = azurerm_public_ip.this.name
}

output "ip_address" {
  description = "Public IP address."
  value       = azurerm_public_ip.this.ip_address
}
