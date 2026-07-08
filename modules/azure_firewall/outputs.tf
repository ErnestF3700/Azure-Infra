
output "id" {
  description = "Resource ID of the Azure Firewall."
  value       = azurerm_firewall.this.id
}

output "name" {
  description = "Name of the Azure Firewall."
  value       = azurerm_firewall.this.name
}

output "location" {
  description = "Azure region."
  value       = azurerm_firewall.this.location
}

output "resource_group_name" {
  description = "Resource Group name."
  value       = azurerm_firewall.this.resource_group_name
}

output "private_ip_address" {
  description = "Private IP address of the Azure Firewall."
  value       = azurerm_firewall.this.ip_configuration[0].private_ip_address
}

output "firewall" {
  description = "Complete Azure Firewall resource."
  value       = azurerm_firewall.this
}
