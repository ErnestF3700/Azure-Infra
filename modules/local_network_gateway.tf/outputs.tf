output "id" {
  description = "Resource ID of the Local Network Gateway."
  value       = azurerm_local_network_gateway.this.id
}

output "name" {
  description = "Name of the Local Network Gateway."
  value       = azurerm_local_network_gateway.this.name
}

output "location" {
  description = "Azure region."
  value       = azurerm_local_network_gateway.this.location
}

output "resource_group_name" {
  description = "Resource Group name."
  value       = azurerm_local_network_gateway.this.resource_group_name
}

output "gateway_address" {
  description = "Gateway public IP address."
  value       = azurerm_local_network_gateway.this.gateway_address
}

output "local_network_gateway" {
  description = "Complete Local Network Gateway resource."
  value       = azurerm_local_network_gateway.this
}
