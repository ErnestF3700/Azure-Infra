output "id" {
  description = "Resource ID of the virtual network."
  value       = azurerm_virtual_network.this.id
}

output "name" {
  description = "Name of the virtual network."
  value       = azurerm_virtual_network.this.name
}

output "location" {
  description = "Azure region of the virtual network."
  value       = azurerm_virtual_network.this.location
}

output "address_space" {
  description = "Address space assigned to the virtual network."
  value       = azurerm_virtual_network.this.address_space
}

output "guid" {
  description = "Globally unique identifier of the virtual network."
  value       = azurerm_virtual_network.this.guid
}

output "resource_group_name" {
  description = "Name of the resource group containing the virtual network."
  value       = azurerm_virtual_network.this.resource_group_name
}
output "virtual_network" {

  description = "Complete Virtual Network object."

  value = azurerm_virtual_network.this

}
