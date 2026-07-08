variable "name" {
  description = "Name of the resource group. The name must follow the Azure CAF convention and start with 'rg-'."
  type        = string

  validation {
    condition     = length(trimspace(var.name)) >= 4 && length(trimspace(var.name)) <= 90
    error_message = "The resource group name must contain between 4 and 90 characters."
  }

  validation {
    condition     = can(regex("^rg-[a-z0-9]([a-z0-9-]*[a-z0-9])?$", trimspace(var.name)))
    error_message = "The resource group name must start with 'rg-', use only lowercase letters, numbers, and hyphens, and must not end with a hyphen."
  }
}

variable "location" {
  description = "Azure region in which to create the resource group, for example 'westeurope'."
  type        = string

  validation {
    condition     = can(regex("^[a-z0-9-]+$", trimspace(var.location)))
    error_message = "The Azure region must be a non-empty canonical region name containing only lowercase letters and numbers, for example 'westeurope'."
  }
}

variable "tags" {
  description = "Enterprise tags to apply to the resource group. Tag keys and values must be non-empty, and Azure supports at most 50 tags per resource."
  type        = map(string)
  default     = {}

  validation {
    condition = (
      length(var.tags) <= 50 &&
      alltrue([for key, value in var.tags : length(trimspace(key)) > 0 && length(key) <= 512 && length(trimspace(value)) > 0 && length(value) <= 256])
    )
    error_message = "Tags must contain at most 50 entries; keys must be 1-512 characters and values must be 1-256 characters after trimming whitespace."
  }
}

variable "management_lock_enabled" {
  description = "Whether to create a management lock on the resource group."
  type        = bool
  default     = false
}

variable "management_lock_name" {
  description = "Name of the management lock. When null, a name is derived from the resource group name."
  type        = string
  default     = null
  nullable    = true

  validation {
    condition = (
      var.management_lock_name == null ||
      (length(trimspace(var.management_lock_name)) >= 1 && length(trimspace(var.management_lock_name)) <= 260)
    )
    error_message = "The management lock name must contain between 1 and 260 characters when specified."
  }
}

variable "management_lock_level" {
  description = "Management lock level. Valid values are 'CanNotDelete' and 'ReadOnly'."
  type        = string
  default     = "CanNotDelete"

  validation {
    condition     = contains(["CanNotDelete", "ReadOnly"], var.management_lock_level)
    error_message = "The management lock level must be either 'CanNotDelete' or 'ReadOnly'."
  }
}

variable "management_lock_notes" {
  description = "Optional notes describing the reason for the management lock."
  type        = string
  default     = "Managed by Terraform."

  validation {
    condition     = length(trimspace(var.management_lock_notes)) >= 1 && length(var.management_lock_notes) <= 512
    error_message = "Management lock notes must contain between 1 and 512 characters."
  }
}
