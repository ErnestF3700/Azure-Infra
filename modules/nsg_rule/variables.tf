variable "name" {
  description = "Name of the Network Security Group."
  type        = string

  validation {
    condition = (
      startswith(var.name, "nsg-") &&
      can(regex("^[a-z0-9-]+$", var.name)) &&
      !endswith(var.name, "-")
    )

    error_message = "The NSG name must start with 'nsg-', use only lowercase letters, numbers, and hyphens, and must not end with a hyphen."
  }
}

variable "location" {
  description = "Azure region where the Network Security Group will be created."
  type        = string
}

variable "resource_group_name" {
  description = "Name of the Resource Group."
  type        = string

  validation {
    condition = (
      startswith(var.resource_group_name, "rg-") &&
      can(regex("^[a-z0-9-]+$", var.resource_group_name)) &&
      !endswith(var.resource_group_name, "-")
    )

    error_message = "The Resource Group name must start with 'rg-', use only lowercase letters, numbers, and hyphens, and must not end with a hyphen."
  }
}

variable "tags" {
  description = "Tags assigned to the Network Security Group."
  type        = map(string)
  default     = {}
}
