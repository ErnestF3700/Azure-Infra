variable "name" {
  description = "Name of the User Assigned Managed Identity."
  type        = string

  validation {
    condition = (
      length(trimspace(var.name)) >= 3 &&
      length(trimspace(var.name)) <= 128 &&
      can(regex("^[A-Za-z0-9._-]+$", trimspace(var.name)))
    )

    error_message = "The identity name must contain 3-128 characters and only letters, numbers, periods, underscores and hyphens."
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
