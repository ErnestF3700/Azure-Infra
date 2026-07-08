output "id" {
  description = "Resource ID of the resource group."
  value       = azurerm_resource_group.this.id
}

output "name" {
  description = "Name of the resource group."
  value       = azurerm_resource_group.this.name
}

output "location" {
  description = "Azure region of the resource group."
  value       = azurerm_resource_group.this.location
}
output "resource_group" {

  description = "Complete Resource Group object."

  value = azurerm_resource_group.this

}
