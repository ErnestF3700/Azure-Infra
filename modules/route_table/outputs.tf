output "id" {
  description = "Resource ID of the Route Table."
  value       = azurerm_route_table.this.id
}

output "name" {
  description = "Name of the Route Table."
  value       = azurerm_route_table.this.name
}

output "location" {
  description = "Azure region in which the Route Table is deployed."
  value       = azurerm_route_table.this.location
}

output "resource_group_name" {
  description = "Name of the resource group containing the Route Table."
  value       = azurerm_route_table.this.resource_group_name
}

output "route_table" {
  description = "Complete Azure Route Table resource object."
  value       = azurerm_route_table.this
}
