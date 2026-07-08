output "id" {
  description = "Resource ID of the Virtual Network Peering."
  value       = azurerm_virtual_network_peering.this.id
}

output "name" {
  description = "Name of the Virtual Network Peering."
  value       = azurerm_virtual_network_peering.this.name
}

output "state" {
  description = "Current state of the Virtual Network Peering."
  value       = azurerm_virtual_network_peering.this.peering_state
}

output "remote_virtual_network_id" {
  description = "Resource ID of the remote Virtual Network."
  value       = azurerm_virtual_network_peering.this.remote_virtual_network_id
}

output "vnet_peering" {
  description = "Complete Azure Virtual Network Peering resource object."
  value       = azurerm_virtual_network_peering.this
}
