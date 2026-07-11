variable "name" {
  description = "Globally unique Azure Container Registry name."
  type        = string

  validation {
    condition     = can(regex("^[a-zA-Z0-9]{5,50}$", trimspace(var.name)))
    error_message = "The registry name must contain 5-50 alphanumeric characters."
  }
}

variable "resource_group_name" {
  description = "Resource Group name."
  type        = string
}

variable "location" {
  description = "Azure region."
  type        = string
}

variable "sku" {
  description = "Container Registry SKU."
  type        = string
  default     = "Premium"

  validation {
    condition     = contains(["Basic", "Standard", "Premium"], var.sku)
    error_message = "SKU must be Basic, Standard or Premium."
  }
}

variable "admin_enabled" {
  description = "Enable admin account."
  type        = bool
  default     = false
}

variable "public_network_access_enabled" {
  description = "Enable public network access."
  type        = bool
  default     = true
}

variable "anonymous_pull_enabled" {
  description = "Allow anonymous image pull."
  type        = bool
  default     = false
}

variable "data_endpoint_enabled" {
  description = "Enable dedicated data endpoints."
  type        = bool
  default     = false
}

variable "network_rule_bypass_option" {
  description = "Network rule bypass option."
  type        = string
  default     = "AzureServices"

  validation {
    condition     = contains(["AzureServices", "None"], var.network_rule_bypass_option)
    error_message = "network_rule_bypass_option must be AzureServices or None."
  }
}

variable "zone_redundancy_enabled" {
  description = "Enable zone redundancy."
  type        = bool
  default     = true
}

variable "identity" {
  description = "Managed Identity configuration."

  type = object({
    type         = string
    identity_ids = optional(list(string), [])
  })

  default = {
    type = "SystemAssigned"
  }

  validation {
    condition = contains([
      "SystemAssigned",
      "UserAssigned",
      "SystemAssigned,UserAssigned"
    ], var.identity.type)

    error_message = "Unsupported identity type."
  }
}

variable "tags" {
  description = "Resource tags."
  type        = map(string)
  default     = {}
}
