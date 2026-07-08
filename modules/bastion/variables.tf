variable "name" {
  description = "Name of the Azure Bastion Host. For CAF-aligned naming, use the `bas-` abbreviation, such as `bas-hub-prod-weu-001`."
  type        = string
  nullable    = false

  validation {
    condition     = length(var.name) >= 1 && length(var.name) <= 80
    error_message = "The Bastion Host name must contain between 1 and 80 characters."
  }

  validation {
    condition     = can(regex("^[A-Za-z0-9](?:[A-Za-z0-9._-]{0,78}[A-Za-z0-9_])?$", var.name))
    error_message = "The Bastion Host name must start with an alphanumeric character, end with an alphanumeric character or underscore, and contain only alphanumeric characters, periods, underscores, or hyphens."
  }
}

variable "resource_group_name" {
  description = "Name of the resource group in which to create the Azure Bastion Host."
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
  description = "Azure region in which to create the Bastion Host."
  type        = string
  nullable    = false

  validation {
    condition     = length(trimspace(var.location)) > 0 && var.location == trimspace(var.location)
    error_message = "The location must be a non-empty Azure region name without leading or trailing whitespace."
  }
}

variable "subnet_id" {
  description = "Resource ID of the existing `AzureBastionSubnet` in which to deploy the Bastion Host."
  type        = string
  nullable    = false

  validation {
    condition = can(regex(
      "(?i)^/subscriptions/[0-9a-f]{8}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{12}/resourceGroups/[^/]+/providers/Microsoft\\.Network/virtualNetworks/[^/]+/subnets/AzureBastionSubnet$",
      var.subnet_id
    ))
    error_message = "The subnet_id must be a valid Azure subnet resource ID whose subnet name is `AzureBastionSubnet`."
  }
}

variable "public_ip_id" {
  description = "Resource ID of the existing Azure Public IP address to associate with the Bastion Host."
  type        = string
  nullable    = false

  validation {
    condition = can(regex(
      "(?i)^/subscriptions/[0-9a-f]{8}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{12}/resourceGroups/[^/]+/providers/Microsoft\\.Network/publicIPAddresses/[^/]+$",
      var.public_ip_id
    ))
    error_message = "The public_ip_id must be a valid Azure Public IP resource ID."
  }
}

variable "ip_configuration_name" {
  description = "Name of the Bastion Host IP configuration."
  type        = string
  default     = "bastion-ip-configuration"
  nullable    = false

  validation {
    condition     = length(trimspace(var.ip_configuration_name)) > 0 && length(var.ip_configuration_name) <= 80 && var.ip_configuration_name == trimspace(var.ip_configuration_name)
    error_message = "The IP configuration name must contain between 1 and 80 characters without leading or trailing whitespace."
  }
}

variable "sku" {
  description = "SKU of the Azure Bastion Host. Valid values are `Basic`, `Standard`, and `Premium`."
  type        = string
  default     = "Basic"
  nullable    = false

  validation {
    condition     = contains(["Basic", "Standard", "Premium"], var.sku)
    error_message = "The sku must be one of `Basic`, `Standard`, or `Premium`."
  }
}

variable "scale_units" {
  description = "Number of Bastion scale units. Valid values are between 2 and 50; Basic requires exactly 2."
  type        = number
  default     = 2
  nullable    = false

  validation {
    condition     = var.scale_units >= 2 && var.scale_units <= 50 && floor(var.scale_units) == var.scale_units
    error_message = "The scale_units value must be a whole number between 2 and 50."
  }

  validation {
    condition     = var.sku != "Basic" || var.scale_units == 2
    error_message = "The Basic SKU supports exactly 2 scale units. Use Standard or Premium to configure additional scale units."
  }
}

variable "copy_paste_enabled" {
  description = "Whether copy and paste is enabled for Bastion sessions."
  type        = bool
  default     = true
  nullable    = false
}

variable "file_copy_enabled" {
  description = "Whether file copy is enabled. This feature requires Standard or Premium."
  type        = bool
  default     = false
  nullable    = false

  validation {
    condition     = !var.file_copy_enabled || contains(["Standard", "Premium"], var.sku)
    error_message = "file_copy_enabled requires the Standard or Premium SKU."
  }
}

variable "ip_connect_enabled" {
  description = "Whether connections to target virtual machines by private IP address are enabled. This feature requires Standard or Premium."
  type        = bool
  default     = false
  nullable    = false

  validation {
    condition     = !var.ip_connect_enabled || contains(["Standard", "Premium"], var.sku)
    error_message = "ip_connect_enabled requires the Standard or Premium SKU."
  }
}

variable "kerberos_enabled" {
  description = "Whether Kerberos authentication is enabled. This feature requires Standard or Premium."
  type        = bool
  default     = false
  nullable    = false

  validation {
    condition     = !var.kerberos_enabled || contains(["Standard", "Premium"], var.sku)
    error_message = "kerberos_enabled requires the Standard or Premium SKU."
  }
}

variable "shareable_link_enabled" {
  description = "Whether shareable links are enabled. This feature requires Standard or Premium."
  type        = bool
  default     = false
  nullable    = false

  validation {
    condition     = !var.shareable_link_enabled || contains(["Standard", "Premium"], var.sku)
    error_message = "shareable_link_enabled requires the Standard or Premium SKU."
  }
}

variable "tunneling_enabled" {
  description = "Whether native client tunneling is enabled. This feature requires Standard or Premium."
  type        = bool
  default     = false
  nullable    = false

  validation {
    condition     = !var.tunneling_enabled || contains(["Standard", "Premium"], var.sku)
    error_message = "tunneling_enabled requires the Standard or Premium SKU."
  }
}

variable "session_recording_enabled" {
  description = "Whether graphical session recording is enabled. This feature requires Premium."
  type        = bool
  default     = false
  nullable    = false

  validation {
    condition     = !var.session_recording_enabled || var.sku == "Premium"
    error_message = "session_recording_enabled requires the Premium SKU."
  }
}

variable "tags" {
  description = "Map of tags to assign to the Bastion Host. Use organizational tags such as environment, owner, cost center, and workload where applicable."
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
