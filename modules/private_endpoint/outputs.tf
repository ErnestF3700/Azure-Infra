output "id" {
  description = "Resource ID."
  value       = azurerm_private_endpoint.this.id
}

output "name" {
  description = "Private Endpoint name."
  value       = azurerm_private_endpoint.this.name
}

output "location" {
  description = "Azure region."
  value       = azurerm_private_endpoint.this.location
}

output "resource_group_name" {
  description = "Resource Group."
  value       = azurerm_private_endpoint.this.resource_group_name
}

output "network_interface" {
  description = "Network Interface ID."
  value       = azurerm_private_endpoint.this.network_interface
}

output "private_endpoint" {
  description = "Complete Private Endpoint resource."
  value       = azurerm_private_endpoint.this
}
