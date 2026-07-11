variable "scope" {
  description = "Scope at which the role assignment applies."
  type        = string

  validation {
    condition     = length(trimspace(var.scope)) > 0
    error_message = "scope cannot be empty."
  }
}

variable "role_definition_name" {
  description = "Built-in Azure role name."
  type        = string
  default     = null
  nullable    = true
}

variable "role_definition_id" {
  description = "Custom Role Definition ID."
  type        = string
  default     = null
  nullable    = true
}

variable "principal_id" {
  description = "Object ID of the principal."
  type        = string

  validation {
    condition = can(regex(
      "^[0-9a-fA-F-]{36}$",
      trimspace(var.principal_id)
    ))

    error_message = "principal_id must be a valid GUID."
  }
}

variable "principal_type" {
  description = "Principal type."
  type        = string
  default     = "ServicePrincipal"

  validation {
    condition = contains([
      "User",
      "Group",
      "ServicePrincipal",
      "ForeignGroup",
      "Device"
    ], var.principal_type)

    error_message = "Unsupported principal type."
  }
}

variable "condition" {
  description = "Optional Azure RBAC condition."
  type        = string
  default     = null
}

variable "condition_version" {
  description = "Condition version."
  type        = string
  default     = "2.0"

  validation {
    condition     = contains(["2.0"], var.condition_version)
    error_message = "Only condition version 2.0 is supported."
  }
}

variable "skip_service_principal_aad_check" {
  description = "Skip Microsoft Entra validation for service principals."
  type        = bool
  default     = false
}

