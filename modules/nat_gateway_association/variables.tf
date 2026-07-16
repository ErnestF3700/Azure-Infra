variable "subnet_id" {
  description = "Resource ID of the Azure Subnet."
  type        = string

  validation {
    condition = can(regex(
      "(?i)^/subscriptions/.+/resourceGroups/.+/providers/Microsoft\\.Network/virtualNetworks/.+/subnets/.+$",
      trimspace(var.subnet_id)
    ))

    error_message = "subnet_id must be a valid Azure Subnet Resource ID."
  }
}

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
