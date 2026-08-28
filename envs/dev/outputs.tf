output "resource_group_id" {
  description = "Resource ID of the development Resource Group."
  value       = module.resource_group.id
}

output "resource_group_name" {
  description = "Name of the development Resource Group."
  value       = module.resource_group.name
}

output "hub_vnet_id" {
  description = "Resource ID of the Hub Virtual Network."
  value       = module.hub_vnet.id
}

output "hub_vnet_name" {
  description = "Name of the Hub Virtual Network."
  value       = module.hub_vnet.name
}

output "spoke_vnet_id" {
  description = "Resource ID of the application Spoke Virtual Network."
  value       = module.spoke_vnet.id
}

output "spoke_vnet_name" {
  description = "Name of the application Spoke Virtual Network."
  value       = module.spoke_vnet.name
}

output "hub_to_spoke_peering_id" {
  description = "Hub to Spoke peering resource ID."
  value       = module.hub_to_spoke.id
}

output "spoke_to_hub_peering_id" {
  description = "Spoke to Hub peering resource ID."
  value       = module.spoke_to_hub.id
}
