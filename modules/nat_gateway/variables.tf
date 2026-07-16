variable "name" {
  description = "Name of the NAT Gateway."
  type        = string

  validation {
    condition     = length(trimspace(var.name)) >= 2 && length(trimspace(var.name)) <= 80
    error_message = "The NAT Gateway name must contain between 2 and 80 characters."
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

variable "sku_name" {
  description = "NAT Gateway SKU."
  type        = string
  default     = "Standard"

  validation {
    condition     = contains(["Standard"], var.sku_name)
    error_message = "Only Standard SKU is supported."
  }
}

variable "idle_timeout_in_minutes" {
  description = "TCP idle timeout in minutes."
  type        = number
  default     = 4

  validation {
    condition     = var.idle_timeout_in_minutes >= 4 && var.idle_timeout_in_minutes <= 120
    error_message = "Idle timeout must be between 4 and 120 minutes."
  }
}

variable "zones" {
  description = "Availability Zones."
  type        = list(string)
  default     = []

  validation {
    condition = alltrue([
      for zone in var.zones :
      contains(["1", "2", "3"], zone)
    ])

    error_message = "Zones must be 1, 2 or 3."
  }
}

variable "tags" {
  description = "Resource tags."
  type        = map(string)
  default     = {}

  validation {
    condition = (
      length(var.tags) <= 50 &&
      alltrue([
        for k, v in var.tags :
        length(trimspace(k)) > 0 &&
        length(k) <= 512 &&
        length(trimspace(v)) > 0 &&
        length(v) <= 256
      ])
    )

    error_message = "Invalid tags."
  }
}
