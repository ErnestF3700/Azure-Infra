output "id" {
  description = "Resource ID of the Subnet NAT Gateway Association."
  value       = azurerm_subnet_nat_gateway_association.this.id
}

output "association" {
  description = "Complete Subnet NAT Gateway Association resource."
  value       = azurerm_subnet_nat_gateway_association.this
}
