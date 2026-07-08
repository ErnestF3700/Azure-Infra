variable "name" {
  description = "Globally unique Key Vault name."
  type        = string

  validation {
    condition     = can(regex("^[a-zA-Z][a-zA-Z0-9-]{1,22}[a-zA-Z0-9]$", trimspace(var.name)))
    error_message = "The Key Vault name must be 3-24 characters, start with a letter and contain only letters, numbers and hyphens."
  }
}

variable "resource_group_name" {
  description = "Name of the Resource Group."
  type        = string
}

variable "location" {
  description = "Azure region."
  type        = string
}

variable "tenant_id" {
  description = "Microsoft Entra tenant ID."
  type        = string

  validation {
    condition = can(regex(
      "^[0-9a-fA-F]{8}-[0-9a-fA-F]{4}-[0-9a-fA-F]{4}-[0-9a-fA-F]{4}-[0-9a-fA-F]{12}$",
      var.tenant_id
    ))

    error_message = "tenant_id must be a valid GUID."
  }
}

variable "sku_name" {
  description = "Key Vault SKU."
  type        = string
  default     = "standard"

  validation {
    condition     = contains(["standard", "premium"], var.sku_name)
    error_message = "sku_name must be standard or premium."
  }
}

variable "purge_protection_enabled" {
  description = "Enable Purge Protection."
  type        = bool
  default     = true
}

variable "soft_delete_retention_days" {
  description = "Soft delete retention."
  type        = number
  default     = 90

  validation {
    condition     = var.soft_delete_retention_days >= 7 && var.soft_delete_retention_days <= 90
    error_message = "Retention must be between 7 and 90 days."
  }
}

variable "enable_rbac_authorization" {
  description = "Enable Azure RBAC authorization."
  type        = bool
  default     = true
}

variable "public_network_access_enabled" {
  description = "Enable public network access."
  type        = bool
  default     = true
}

variable "network_acls" {
  description = "Optional network ACL configuration."

  type = object({
    bypass                     = string
    default_action             = string
    ip_rules                   = list(string)
    virtual_network_subnet_ids = list(string)
  })
  validation {
    condition = contains(
      ["Allow", "Deny"],
      var.network_acls.default_action
    )

    error_message = "network_acls.default_action must be Allow or Deny."
  }
  validation {
    condition = contains(
      ["AzureServices", "None"],
      var.network_acls.bypass
    )

    error_message = "network_acls.bypass must be AzureServices or None."
  }
  default = {
    bypass                     = "AzureServices"
    default_action             = "Deny"
    ip_rules                   = []
    virtual_network_subnet_ids = []
  }
}

variable "tags" {
  description = "Resource tags."
  type        = map(string)
  default     = {}
}
