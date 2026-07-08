variable "name" {
  description = "Private DNS Zone Virtual Network Link name."
  type        = string
}

variable "resource_group_name" {
  description = "Resource Group containing the Private DNS Zone."
  type        = string
}

variable "private_dns_zone_name" {
  description = "Private DNS Zone name."
  type        = string
}

variable "virtual_network_id" {
  description = "Virtual Network Resource ID."
  type        = string

  validation {
    condition = can(regex(
      "(?i)^/subscriptions/.+/resourceGroups/.+/providers/Microsoft\\.Network/virtualNetworks/.+$",
      var.virtual_network_id
    ))

    error_message = "virtual_network_id must be a valid Azure Virtual Network Resource ID."
  }
}

variable "registration_enabled" {
  description = "Enable automatic DNS registration."
  type        = bool
  default     = false
}

variable "tags" {
  description = "Resource tags."
  type        = map(string)
  default     = {}
}
