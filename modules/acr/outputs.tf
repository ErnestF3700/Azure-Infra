output "id" {
  description = "Resource ID of the Container Registry."
  value       = azurerm_container_registry.this.id
}

output "name" {
  description = "Container Registry name."
  value       = azurerm_container_registry.this.name
}

output "location" {
  description = "Azure region."
  value       = azurerm_container_registry.this.location
}

output "resource_group_name" {
  description = "Resource Group."
  value       = azurerm_container_registry.this.resource_group_name
}

output "login_server" {
  description = "Container Registry login server."
  value       = azurerm_container_registry.this.login_server
}

output "admin_username" {
  description = "Admin username."
  value       = azurerm_container_registry.this.admin_username
}

output "admin_password" {
  description = "Admin password."
  value       = azurerm_container_registry.this.admin_password
  sensitive   = true
}

output "identity" {
  description = "Managed Identity."
  value       = azurerm_container_registry.this.identity
}

output "acr" {
  description = "Complete Container Registry resource."
  value       = azurerm_container_registry.this
}
