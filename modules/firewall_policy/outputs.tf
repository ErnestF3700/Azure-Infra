
output "id" {
  description = "Resource ID of the Firewall Policy."
  value       = azurerm_firewall_policy.this.id
}

output "name" {
  description = "Name of the Firewall Policy."
  value       = azurerm_firewall_policy.this.name
}

output "location" {
  description = "Azure region."
  value       = azurerm_firewall_policy.this.location
}

output "resource_group_name" {
  description = "Resource Group name."
  value       = azurerm_firewall_policy.this.resource_group_name
}

output "firewall_policy" {
  description = "Complete Firewall Policy resource."
  value       = azurerm_firewall_policy.this
}
