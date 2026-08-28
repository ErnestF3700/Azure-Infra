variable "environment" {
  description = "Environment name."
  type        = string

  default = "dev"

  validation {
    condition     = var.environment == "dev"
    error_message = "This root configuration is dedicated to the dev environment."
  }
}

variable "location" {
  description = "Primary Azure region."
  type        = string

  default = "westeurope"
}

variable "resource_group_name" {
  description = "Resource Group name."
  type        = string
}

variable "hub_address_space" {
  description = "CIDR range for the Hub VNet."
  type        = list(string)

  validation {
    condition     = length(var.hub_address_space) > 0
    error_message = "At least one Hub address space must be specified."
  }
}

variable "spoke_address_space" {
  description = "CIDR range for the application Spoke VNet."
  type        = list(string)

  validation {
    condition     = length(var.spoke_address_space) > 0
    error_message = "At least one Spoke address space must be specified."
  }
}

variable "tags" {
  description = "Common resource tags."
  type        = map(string)
  default     = {}
}
