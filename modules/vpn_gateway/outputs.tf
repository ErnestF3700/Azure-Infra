output "id" {
  description = "Resource ID of the Virtual Network Gateway."
  value       = azurerm_virtual_network_gateway.this.id
}

output "name" {
  description = "Name of the Virtual Network Gateway."
  value       = azurerm_virtual_network_gateway.this.name
}

output "location" {
  description = "Azure region in which the Virtual Network Gateway is deployed."
  value       = azurerm_virtual_network_gateway.this.location
}

output "resource_group_name" {
  description = "Name of the resource group containing the Virtual Network Gateway."
  value       = azurerm_virtual_network_gateway.this.resource_group_name
}

output "vpn_gateway" {
  description = "Complete Azure Virtual Network Gateway resource object."
  value       = azurerm_virtual_network_gateway.this
}
