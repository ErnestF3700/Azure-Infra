variable "name" {
  description = "Name of the Log Analytics Workspace."
  type        = string

  validation {
    condition = (
      length(trimspace(var.name)) >= 4 &&
      length(trimspace(var.name)) <= 63
    )

    error_message = "Workspace name must contain between 4 and 63 characters."
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
  description = "Workspace SKU."
  type        = string
  default     = "PerGB2018"

  validation {
    condition = contains([
      "Free",
      "PerNode",
      "PerGB2018",
      "Standalone",
      "CapacityReservation"
    ], var.sku)

    error_message = "Unsupported SKU."
  }
}

variable "retention_in_days" {
  description = "Workspace data retention."
  type        = number
  default     = 30

  validation {
    condition = (
      var.retention_in_days >= 30 &&
      var.retention_in_days <= 730
    )

    error_message = "Retention must be between 30 and 730 days."
  }
}

variable "daily_quota_gb" {
  description = "Daily ingestion quota."
  type        = number
  default     = -1
}

variable "internet_ingestion_enabled" {
  description = "Enable public ingestion endpoint."
  type        = bool
  default     = true
}

variable "internet_query_enabled" {
  description = "Enable public query endpoint."
  type        = bool
  default     = true
}

variable "local_authentication_disabled" {
  description = "Disable local authentication."
  type        = bool
  default     = false
}

variable "reservation_capacity_in_gb_per_day" {
  description = "Capacity reservation."
  type        = number
  default     = null
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
