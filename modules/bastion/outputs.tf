output "id" {
  description = "Resource ID of the Azure Bastion Host."
  value       = azurerm_bastion_host.this.id
}

output "name" {
  description = "Name of the Azure Bastion Host."
  value       = azurerm_bastion_host.this.name
}

output "location" {
  description = "Azure region in which the Bastion Host is deployed."
  value       = azurerm_bastion_host.this.location
}

output "resource_group_name" {
  description = "Name of the resource group containing the Bastion Host."
  value       = azurerm_bastion_host.this.resource_group_name
}

output "dns_name" {
  description = "Fully qualified domain name of the Azure Bastion Host."
  value       = azurerm_bastion_host.this.dns_name
}

output "bastion_host" {
  description = "Complete Azure Bastion Host resource object."
  value       = azurerm_bastion_host.this
}
