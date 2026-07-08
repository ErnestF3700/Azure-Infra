output "id" {
  description = "Resource ID of the Subnet Route Table Association."
  value       = azurerm_subnet_route_table_association.this.id
}

output "association" {
  description = "Complete Azure Subnet Route Table Association resource object."
  value       = azurerm_subnet_route_table_association.this
}
