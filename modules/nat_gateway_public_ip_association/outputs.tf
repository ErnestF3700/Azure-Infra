output "id" {
  description = "Resource ID of the NAT Gateway Public IP Association."
  value       = azurerm_nat_gateway_public_ip_association.this.id
}

output "association" {
  description = "Complete NAT Gateway Public IP Association resource."
  value       = azurerm_nat_gateway_public_ip_association.this
}
