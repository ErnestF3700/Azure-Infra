variable "subnet_id" {
  description = "Resource ID of the existing Azure subnet to associate with the network security group."
  type        = string

  validation {
    condition = can(regex(
      "(?i)^/subscriptions/[0-9a-f]{8}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{12}/resourcegroups/[^/]+/providers/microsoft\\.network/virtualnetworks/[^/]+/subnets/[^/]+$",
      trimspace(var.subnet_id)
    ))
    error_message = "The subnet ID must be a valid Azure resource ID for Microsoft.Network/virtualNetworks/subnets."
  }
}

variable "network_security_group_id" {
  description = "Resource ID of the existing Azure Network Security Group to associate with the subnet."
  type        = string

  validation {
    condition = can(regex(
      "(?i)^/subscriptions/[0-9a-f]{8}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{12}/resourcegroups/[^/]+/providers/microsoft\\.network/networksecuritygroups/[^/]+$",
      trimspace(var.network_security_group_id)
    ))
    error_message = "The network security group ID must be a valid Azure resource ID for Microsoft.Network/networkSecurityGroups."
  }
}
