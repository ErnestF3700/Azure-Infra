output "id" {
  description = "Resource ID of the Private DNS Zone."
  value       = azurerm_private_dns_zone.this.id
}

output "name" {
  description = "Private DNS Zone name."
  value       = azurerm_private_dns_zone.this.name
}

output "number_of_record_sets" {
  description = "Number of DNS record sets."
  value       = azurerm_private_dns_zone.this.number_of_record_sets
}

output "max_number_of_record_sets" {
  description = "Maximum supported record sets."
  value       = azurerm_private_dns_zone.this.max_number_of_record_sets
}

output "max_number_of_virtual_network_links" {
  description = "Maximum supported virtual network links."
  value       = azurerm_private_dns_zone.this.max_number_of_virtual_network_links
}

output "resource_group_name" {
  description = "Resource Group name."
  value       = azurerm_private_dns_zone.this.resource_group_name
}

output "private_dns_zone" {
  description = "Complete Private DNS Zone resource."
  value       = azurerm_private_dns_zone.this
}
