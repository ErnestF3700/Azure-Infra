variable "name" {
  description = "Name of the Storage Account. Must be globally unique."
  type        = string

  validation {
    condition     = can(regex("^[a-z0-9]{3,24}$", trimspace(var.name)))
    error_message = "The storage account name must contain 3-24 lowercase letters or numbers."
  }
}

variable "resource_group_name" {
  description = "Name of the Resource Group."
  type        = string

  validation {
    condition     = length(trimspace(var.resource_group_name)) >= 1
    error_message = "Resource Group name cannot be empty."
  }
}

variable "location" {
  description = "Azure region."
  type        = string

  validation {
    condition     = length(trimspace(var.location)) >= 1
    error_message = "Location cannot be empty."
  }
}

variable "account_kind" {
  description = "Storage Account kind."
  type        = string
  default     = "StorageV2"

  validation {
    condition = contains([
      "Storage",
      "StorageV2",
      "BlobStorage",
      "BlockBlobStorage",
      "FileStorage"
    ], var.account_kind)

    error_message = "Invalid account kind."
  }
}

variable "account_tier" {
  description = "Storage Account performance tier."
  type        = string
  default     = "Standard"

  validation {
    condition     = contains(["Standard", "Premium"], var.account_tier)
    error_message = "account_tier must be Standard or Premium."
  }
}

variable "account_replication_type" {
  description = "Replication type."
  type        = string
  default     = "ZRS"

  validation {
    condition = contains([
      "LRS",
      "GRS",
      "RAGRS",
      "ZRS",
      "GZRS",
      "RAGZRS"
    ], var.account_replication_type)

    error_message = "Invalid replication type."
  }
}

variable "access_tier" {
  description = "Blob access tier."
  type        = string
  default     = "Hot"

  validation {
    condition     = contains(["Hot", "Cool"], var.access_tier)
    error_message = "access_tier must be Hot or Cool."
  }
}

variable "min_tls_version" {
  description = "Minimum supported TLS version."
  type        = string
  default     = "TLS1_2"

  validation {
    condition = contains([
      "TLS1_0",
      "TLS1_1",
      "TLS1_2"
    ], var.min_tls_version)

    error_message = "Invalid TLS version."
  }
}

variable "https_traffic_only_enabled" {
  description = "Allow HTTPS traffic only."
  type        = bool
  default     = true
}

variable "public_network_access_enabled" {
  description = "Enable public network access."
  type        = bool
  default     = true
}

variable "shared_access_key_enabled" {
  description = "Enable shared key authentication."
  type        = bool
  default     = false
}

variable "allow_nested_items_to_be_public" {
  description = "Allow nested blob containers to be public."
  type        = bool
  default     = false
}

variable "is_hns_enabled" {
  description = "Enable hierarchical namespace (Data Lake Gen2)."
  type        = bool
  default     = false
}

variable "nfsv3_enabled" {
  description = "Enable NFSv3."
  type        = bool
  default     = false
}

variable "sftp_enabled" {
  description = "Enable SFTP."
  type        = bool
  default     = false
}

variable "large_file_share_enabled" {
  description = "Enable Large File Share."
  type        = bool
  default     = false
}

variable "blob_versioning_enabled" {
  description = "Enable Blob Versioning."
  type        = bool
  default     = true
}

variable "delete_retention_days" {
  description = "Blob delete retention in days."
  type        = number
  default     = 30

  validation {
    condition     = var.delete_retention_days >= 1 && var.delete_retention_days <= 365
    error_message = "Delete retention must be between 1 and 365 days."
  }
}

variable "container_delete_retention_days" {
  description = "Container delete retention in days."
  type        = number
  default     = 30

  validation {
    condition     = var.container_delete_retention_days >= 1 && var.container_delete_retention_days <= 365
    error_message = "Container delete retention must be between 1 and 365 days."
  }
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

    error_message = "Invalid identity type."
  }
}

variable "network_rules" {
  description = "Network ACL configuration."

  type = object({
    default_action             = string
    bypass                     = list(string)
    ip_rules                   = list(string)
    virtual_network_subnet_ids = list(string)
  })

  default = {
    default_action             = "Deny"
    bypass                     = ["AzureServices"]
    ip_rules                   = []
    virtual_network_subnet_ids = []
  }

  validation {
    condition     = contains(["Allow", "Deny"], var.network_rules.default_action)
    error_message = "default_action must be Allow or Deny."
  }
}

variable "tags" {
  description = "Resource tags."
  type        = map(string)
  default     = {}
}
