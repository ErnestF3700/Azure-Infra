output "id" {
  description = "Resource ID of the subnet."
  value       = azurerm_subnet.this.id
}

output "name" {
  description = "Name of the subnet."
  value       = azurerm_subnet.this.name
}

output "address_prefixes" {
  description = "Address prefixes assigned to the subnet."
  value       = azurerm_subnet.this.address_prefixes
}

output "virtual_network_name" {
  description = "Name of the virtual network containing the subnet."
  value       = azurerm_subnet.this.virtual_network_name
}

output "resource_group_name" {
  description = "Name of the resource group containing the subnet."
  value       = azurerm_subnet.this.resource_group_name
}

output "subnet" {
  description = "Complete Subnet resource."
  value       = azurerm_subnet.this
}
