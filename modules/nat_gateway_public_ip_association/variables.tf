variable "nat_gateway_id" {
  description = "Resource ID of the Azure NAT Gateway."
  type        = string

  validation {
    condition = can(regex(
      "(?i)^/subscriptions/.+/resourceGroups/.+/providers/Microsoft\\.Network/natGateways/.+$",
      trimspace(var.nat_gateway_id)
    ))

    error_message = "nat_gateway_id must be a valid Azure NAT Gateway Resource ID."
  }
}

variable "public_ip_address_id" {
  description = "Resource ID of the Azure Public IP Address."
  type        = string

  validation {
    condition = can(regex(
      "(?i)^/subscriptions/.+/resourceGroups/.+/providers/Microsoft\\.Network/publicIPAddresses/.+$",
      trimspace(var.public_ip_address_id)
    ))

    error_message = "public_ip_address_id must be a valid Azure Public IP Resource ID."
  }
}
