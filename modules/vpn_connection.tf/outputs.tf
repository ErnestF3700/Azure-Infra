output "id" {
  description = "Resource ID of the VPN Connection."
  value       = azurerm_virtual_network_gateway_connection.this.id
}

output "name" {
  description = "Name of the VPN Connection."
  value       = azurerm_virtual_network_gateway_connection.this.name
}

output "vpn_connection" {
  description = "Complete VPN Connection resource."
  value       = azurerm_virtual_network_gateway_connection.this
}
