output "id" {
  description = "Resource ID of the subnet Network Security Group association."
  value       = azurerm_subnet_network_security_group_association.this.id
}

output "association" {
  description = "Complete NSG association resource."
  value       = azurerm_subnet_network_security_group_association.this
}
