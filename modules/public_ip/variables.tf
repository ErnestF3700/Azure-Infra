variable "name" {
  description = "Name of the Azure Public IP."
  type        = string

  validation {
    condition     = can(regex("^pip-[a-z0-9]([a-z0-9-]*[a-z0-9])?$", trimspace(var.name)))
    error_message = "Public IP name must follow CAF naming and start with 'pip-'."
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

variable "allocation_method" {
  description = "Static or Dynamic."
  type        = string
  default     = "Static"

  validation {
    condition = contains([
      "Static",
      "Dynamic"
    ], var.allocation_method)

    error_message = "allocation_method must be Static or Dynamic."
  }
}

variable "sku" {
  description = "Public IP SKU."
  type        = string
  default     = "Standard"

  validation {
    condition = contains([
      "Basic",
      "Standard"
    ], var.sku)

    error_message = "SKU must be Basic or Standard."
  }
}

variable "sku_tier" {
  description = "SKU Tier."
  type        = string
  default     = "Regional"

  validation {
    condition = contains([
      "Regional",
      "Global"
    ], var.sku_tier)

    error_message = "sku_tier must be Regional or Global."
  }
}

variable "ip_version" {
  description = "IPv4 or IPv6."
  type        = string
  default     = "IPv4"

  validation {
    condition = contains([
      "IPv4",
      "IPv6"
    ], var.ip_version)

    error_message = "ip_version must be IPv4 or IPv6."
  }
}

variable "zones" {
  description = "Availability Zones."
  type        = list(string)
  default     = []
}

variable "domain_name_label" {
  description = "Optional DNS label."
  type        = string
  default     = null
}

variable "reverse_fqdn" {
  description = "Optional reverse FQDN."
  type        = string
  default     = null
}

variable "edge_zone" {
  description = "Optional Edge Zone."
  type        = string
  default     = null
}

variable "idle_timeout_in_minutes" {
  description = "Idle timeout."
  type        = number
  default     = 4

  validation {
    condition = (
      var.idle_timeout_in_minutes >= 4 &&
      var.idle_timeout_in_minutes <= 30
    )

    error_message = "Idle timeout must be between 4 and 30 minutes."
  }
}

variable "tags" {
  description = "Tags."

  type = map(string)

  default = {}
}
