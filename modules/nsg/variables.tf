variable "name" {
  description = "Name of the network security group. The name must follow the Azure CAF convention and start with 'nsg-'."
  type        = string

  validation {
    condition     = length(trimspace(var.name)) >= 5 && length(trimspace(var.name)) <= 80
    error_message = "The network security group name must contain between 5 and 80 characters."
  }

  validation {
    condition     = can(regex("^nsg-[a-z0-9]([a-z0-9-]*[a-z0-9])?$", trimspace(var.name)))
    error_message = "The network security group name must start with 'nsg-', use only lowercase letters, numbers, and hyphens, and must not end with a hyphen."
  }
}

variable "resource_group_name" {
  description = "Name of the existing resource group in which to create the network security group. The name must follow the Azure CAF convention and start with 'rg-'."
  type        = string

  validation {
    condition     = length(trimspace(var.resource_group_name)) >= 4 && length(trimspace(var.resource_group_name)) <= 90
    error_message = "The resource group name must contain between 4 and 90 characters."
  }

  validation {
    condition     = can(regex("^rg-[a-z0-9]([a-z0-9-]*[a-z0-9])?$", trimspace(var.resource_group_name)))
    error_message = "The resource group name must start with 'rg-', use only lowercase letters, numbers, and hyphens, and must not end with a hyphen."
  }
}

variable "location" {
  description = "Azure region in which to create the network security group, for example 'westeurope'."
  type        = string

  validation {
    condition     = can(regex("^[a-z0-9-]+$", trimspace(var.location)))
    error_message = "The Azure region must be a non-empty canonical region name containing only lowercase letters and numbers, for example 'westeurope'."
  }
}

variable "tags" {
  description = "Enterprise tags to apply to the network security group. Tag keys and values must be non-empty, and Azure supports at most 50 tags per resource."
  type        = map(string)
  default     = {}

  validation {
    condition = (
      length(var.tags) <= 50 &&
      alltrue([
        for key, value in var.tags :
        length(trimspace(key)) > 0 && length(key) <= 512 &&
        length(trimspace(value)) > 0 && length(value) <= 256
      ])
    )
    error_message = "Tags must contain at most 50 entries; keys must be 1-512 characters and values must be 1-256 characters after trimming whitespace."
  }
}
