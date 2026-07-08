variable "name" {
  description = "Name of the Azure Virtual Network Gateway. For CAF-aligned naming, use the `vgw-` abbreviation."
  type        = string
  nullable    = false

  validation {
    condition     = length(var.name) >= 1 && length(var.name) <= 80
    error_message = "The gateway name must contain between 1 and 80 characters."
  }

  validation {
    condition     = can(regex("^[A-Za-z0-9](?:[A-Za-z0-9._-]{0,78}[A-Za-z0-9_])?$", var.name))
    error_message = "The gateway name must start with an alphanumeric character, end with an alphanumeric character or underscore, and contain only alphanumeric characters, periods, underscores, or hyphens."
  }
}

variable "resource_group_name" {
  description = "Name of the resource group in which to create the Virtual Network Gateway."
  type        = string
  nullable    = false

  validation {
    condition     = length(var.resource_group_name) >= 1 && length(var.resource_group_name) <= 90
    error_message = "The resource group name must contain between 1 and 90 characters."
  }

  validation {
    condition     = can(regex("^[A-Za-z0-9_().-]*[A-Za-z0-9_()-]$", var.resource_group_name))
    error_message = "The resource group name may contain alphanumeric characters, underscores, parentheses, hyphens, and periods, but must not end with a period."
  }
}

variable "location" {
  description = "Azure region in which to create the Virtual Network Gateway."
  type        = string
  nullable    = false

  validation {
    condition     = length(trimspace(var.location)) > 0 && var.location == trimspace(var.location)
    error_message = "The location must be a non-empty Azure region name without leading or trailing whitespace."
  }
}

variable "gateway_type" {
  description = "Type of Virtual Network Gateway. Valid values are `Vpn` and `ExpressRoute`."
  type        = string
  default     = "Vpn"
  nullable    = false

  validation {
    condition     = contains(["Vpn", "ExpressRoute"], var.gateway_type)
    error_message = "The gateway_type must be either `Vpn` or `ExpressRoute`."
  }
}

variable "vpn_type" {
  description = "Routing type of the gateway. Valid values are `RouteBased` and `PolicyBased`; ExpressRoute gateways require `RouteBased`."
  type        = string
  default     = "RouteBased"
  nullable    = false

  validation {
    condition     = contains(["RouteBased", "PolicyBased"], var.vpn_type)
    error_message = "The vpn_type must be either `RouteBased` or `PolicyBased`."
  }

  validation {
    condition     = var.gateway_type == "Vpn" || var.vpn_type == "RouteBased"
    error_message = "ExpressRoute gateways require vpn_type to be `RouteBased`."
  }

  validation {
    condition     = var.vpn_type != "PolicyBased" || var.sku == "Basic"
    error_message = "PolicyBased VPN gateways support only the Basic SKU."
  }
}

variable "sku" {
  description = "Gateway SKU. VPN gateways support `Basic`, `VpnGw1` through `VpnGw5`, and their AZ variants. ExpressRoute gateways support `Standard`, `HighPerformance`, `UltraPerformance`, `ErGw1AZ`, `ErGw2AZ`, `ErGw3AZ`, and `ErGwScale`."
  type        = string
  nullable    = false

  validation {
    condition = var.gateway_type == "Vpn" ? contains([
      "Basic",
      "VpnGw1",
      "VpnGw2",
      "VpnGw3",
      "VpnGw4",
      "VpnGw5",
      "VpnGw1AZ",
      "VpnGw2AZ",
      "VpnGw3AZ",
      "VpnGw4AZ",
      "VpnGw5AZ"
      ], var.sku) : contains([
      "Standard",
      "HighPerformance",
      "UltraPerformance",
      "ErGw1AZ",
      "ErGw2AZ",
      "ErGw3AZ",
      "ErGwScale"
    ], var.sku)
    error_message = "The sku must be supported by the selected gateway_type."
  }
}

variable "generation" {
  description = "Generation of the Virtual Network Gateway. Valid values are `Generation1` and `Generation2`."
  type        = string
  default     = "Generation2"
  nullable    = false

  validation {
    condition     = contains(["Generation1", "Generation2"], var.generation)
    error_message = "The generation must be either `Generation1` or `Generation2`."
  }

  validation {
    condition = var.gateway_type != "Vpn" || var.generation != "Generation2" || contains([
      "VpnGw2",
      "VpnGw3",
      "VpnGw4",
      "VpnGw5",
      "VpnGw2AZ",
      "VpnGw3AZ",
      "VpnGw4AZ",
      "VpnGw5AZ"
    ], var.sku)
    error_message = "Generation2 VPN gateways require a VpnGw2 through VpnGw5 SKU or its AZ variant."
  }
}

variable "active_active" {
  description = "Whether to deploy the gateway in active-active mode. A secondary public IP is required when enabled."
  type        = bool
  default     = false
  nullable    = false

  validation {
    condition     = !var.active_active || var.sku != "Basic"
    error_message = "The Basic VPN gateway SKU does not support active-active mode."
  }
}

variable "enable_bgp" {
  description = "Whether Border Gateway Protocol is enabled on the gateway."
  type        = bool
  default     = false
  nullable    = false

  validation {
    condition     = !var.enable_bgp || var.sku != "Basic"
    error_message = "The Basic VPN gateway SKU does not support BGP."
  }
}

variable "private_ip_address_allocation" {
  description = "Private IP allocation method for each gateway IP configuration. Azure Virtual Network Gateways currently support only `Dynamic`."
  type        = string
  default     = "Dynamic"
  nullable    = false

  validation {
    condition     = var.private_ip_address_allocation == "Dynamic"
    error_message = "The private_ip_address_allocation must be `Dynamic`; Azure Virtual Network Gateways do not support static interface allocation."
  }
}

variable "subnet_id" {
  description = "Resource ID of the `GatewaySubnet` in which to deploy the Virtual Network Gateway."
  type        = string
  nullable    = false

  validation {
    condition = can(regex(
      "(?i)^/subscriptions/[0-9a-f]{8}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{12}/resourceGroups/[^/]+/providers/Microsoft\\.Network/virtualNetworks/[^/]+/subnets/GatewaySubnet$",
      var.subnet_id
    ))
    error_message = "The subnet_id must be a valid Azure subnet resource ID whose subnet name is `GatewaySubnet`."
  }
}

variable "public_ip_id" {
  description = "Resource ID of the existing primary Azure Public IP address. Required for VPN gateways and must be null for ExpressRoute gateways."
  type        = string
  default     = null

  validation {
    condition = var.public_ip_id == null || can(regex(
      "(?i)^/subscriptions/[0-9a-f]{8}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{12}/resourceGroups/[^/]+/providers/Microsoft\\.Network/publicIPAddresses/[^/]+$",
      var.public_ip_id
    ))
    error_message = "The public_ip_id must be a valid Azure Public IP resource ID."
  }

  validation {
    condition     = var.gateway_type == "Vpn" ? var.public_ip_id != null : var.public_ip_id == null
    error_message = "public_ip_id is required for VPN gateways and must be null for ExpressRoute gateways."
  }
}

variable "secondary_public_ip_id" {
  description = "Resource ID of the existing secondary Azure Public IP address. Required for active-active VPN gateways and must be null for ExpressRoute gateways."
  type        = string
  default     = null

  validation {
    condition = var.secondary_public_ip_id == null || can(regex(
      "(?i)^/subscriptions/[0-9a-f]{8}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{12}/resourceGroups/[^/]+/providers/Microsoft\\.Network/publicIPAddresses/[^/]+$",
      var.secondary_public_ip_id
    ))
    error_message = "The secondary_public_ip_id must be null or a valid Azure Public IP resource ID."
  }

  validation {
    condition     = !(var.gateway_type == "Vpn" && var.active_active) || var.secondary_public_ip_id != null
    error_message = "A secondary_public_ip_id is required when active_active is enabled for a VPN gateway."
  }

  validation {
    condition     = var.gateway_type == "Vpn" || var.secondary_public_ip_id == null
    error_message = "secondary_public_ip_id must be null for ExpressRoute gateways."
  }

  validation {
    condition     = var.secondary_public_ip_id == null || lower(coalesce(var.secondary_public_ip_id, "")) != lower(coalesce(var.public_ip_id, ""))
    error_message = "The primary and secondary Public IP resource IDs must be different."
  }
}

variable "tags" {
  description = "Map of tags to assign to the Virtual Network Gateway. Use organizational tags such as environment, owner, cost center, and workload where applicable."
  type        = map(string)
  default     = {}
  nullable    = false

  validation {
    condition = alltrue([
      for key, value in var.tags :
      length(trimspace(key)) >= 1 &&
      length(key) <= 512 &&
      length(value) <= 256
    ])
    error_message = "Each tag key must contain 1 to 512 characters and each tag value must contain no more than 256 characters."
  }
}
