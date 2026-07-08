variable "name" {
  description = "Name of the Virtual Network Peering. For CAF-aligned naming, use the `peer-` abbreviation, such as `peer-spoke-to-hub-prod-weu`."
  type        = string
  nullable    = false

  validation {
    condition     = length(var.name) >= 1 && length(var.name) <= 80
    error_message = "The peering name must contain between 1 and 80 characters."
  }

  validation {
    condition     = can(regex("^[A-Za-z0-9](?:[A-Za-z0-9._-]{0,78}[A-Za-z0-9_])?$", var.name))
    error_message = "The peering name must start with an alphanumeric character, end with an alphanumeric character or underscore, and contain only alphanumeric characters, periods, underscores, or hyphens."
  }
}

variable "resource_group_name" {
  description = "Name of the resource group containing the local Virtual Network."
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

variable "virtual_network_name" {
  description = "Name of the local Azure Virtual Network."
  type        = string
  nullable    = false

  validation {
    condition     = length(var.virtual_network_name) >= 2 && length(var.virtual_network_name) <= 64
    error_message = "The local Virtual Network name must contain between 2 and 64 characters."
  }

  validation {
    condition     = can(regex("^[A-Za-z0-9](?:[A-Za-z0-9._-]{0,62}[A-Za-z0-9_])$", var.virtual_network_name))
    error_message = "The local Virtual Network name must start with an alphanumeric character, end with an alphanumeric character or underscore, and contain only alphanumeric characters, periods, underscores, or hyphens."
  }
}

variable "remote_virtual_network_id" {
  description = "Fully qualified resource ID of the remote Azure Virtual Network. The remote network may be in another region or subscription."
  type        = string
  nullable    = false

  validation {
    condition = can(regex(
      "(?i)^/subscriptions/[0-9a-f]{8}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{12}/resourceGroups/[^/]+/providers/Microsoft\\.Network/virtualNetworks/[^/]+$",
      var.remote_virtual_network_id
    ))
    error_message = "The remote_virtual_network_id must be a valid Azure Virtual Network resource ID in the form `/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Network/virtualNetworks/{virtualNetworkName}`."
  }
}

variable "allow_virtual_network_access" {
  description = "Whether the local and remote Virtual Networks may access each other through this peering."
  type        = bool
  default     = true
  nullable    = false
}

variable "allow_forwarded_traffic" {
  description = "Whether traffic forwarded by a network virtual appliance in the remote Virtual Network is allowed through this peering."
  type        = bool
  default     = false
  nullable    = false
}

variable "allow_gateway_transit" {
  description = "Whether the local Virtual Network gateway may be used by the remote Virtual Network. Commonly enabled on the hub-to-spoke peering."
  type        = bool
  default     = false
  nullable    = false
}

variable "use_remote_gateways" {
  description = "Whether the local Virtual Network uses the remote Virtual Network gateway. Commonly enabled on the spoke-to-hub peering."
  type        = bool
  default     = false
  nullable    = false

  validation {
    condition     = !(var.use_remote_gateways && var.allow_gateway_transit)
    error_message = "use_remote_gateways and allow_gateway_transit cannot both be enabled on the same peering."
  }
}
