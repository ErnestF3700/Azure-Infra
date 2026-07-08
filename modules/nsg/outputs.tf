output "id" {
  description = "Resource ID of the network security group."
  value       = azurerm_network_security_group.this.id
}

output "name" {
  description = "Name of the network security group."
  value       = azurerm_network_security_group.this.name
}

output "location" {
  description = "Azure region of the network security group."
  value       = azurerm_network_security_group.this.location
}

output "resource_group_name" {
  description = "Name of the resource group containing the network security group."
  value       = azurerm_network_security_group.this.resource_group_name
}
output "network_security_group" {
  description = "Complete Network Security Group resource."
  value       = azurerm_network_security_group.this
}
