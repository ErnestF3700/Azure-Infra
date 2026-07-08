output "id" {
  description = "Resource ID of the Private DNS Zone Virtual Network Link."
  value       = azurerm_private_dns_zone_virtual_network_link.this.id
}

output "name" {
  description = "Private DNS Zone Virtual Network Link name."
  value       = azurerm_private_dns_zone_virtual_network_link.this.name
}

output "resource_group_name" {
  description = "Resource Group name."
  value       = azurerm_private_dns_zone_virtual_network_link.this.resource_group_name
}

output "private_dns_zone_name" {
  description = "Private DNS Zone name."
  value       = azurerm_private_dns_zone_virtual_network_link.this.private_dns_zone_name
}

output "virtual_network_id" {
  description = "Linked Virtual Network Resource ID."
  value       = azurerm_private_dns_zone_virtual_network_link.this.virtual_network_id
}

output "private_dns_zone_link" {
  description = "Complete Private DNS Zone Virtual Network Link resource."
  value       = azurerm_private_dns_zone_virtual_network_link.this
}
