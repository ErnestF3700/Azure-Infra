variable "name" {
  description = "Name of the Key Vault Secret."
  type        = string

  validation {
    condition     = length(trimspace(var.name)) >= 1 && length(trimspace(var.name)) <= 127
    error_message = "The secret name must contain between 1 and 127 characters."
  }
}

variable "key_vault_id" {
  description = "Resource ID of the Key Vault."
  type        = string

  validation {
    condition = can(regex(
      "(?i)^/subscriptions/.+/resourceGroups/.+/providers/Microsoft\\.KeyVault/vaults/.+$",
      trimspace(var.key_vault_id)
    ))

    error_message = "key_vault_id must be a valid Azure Key Vault Resource ID."
  }
}

variable "value" {
  description = "Secret value."
  type        = string
  sensitive   = true
}

variable "content_type" {
  description = "Optional content type."
  type        = string
  default     = null
}

variable "expiration_date" {
  description = "Optional expiration date (RFC3339)."
  type        = string
  default     = null

  validation {
    condition = (
      var.expiration_date == null ||
      can(formatdate("", var.expiration_date))
    )

    error_message = "expiration_date must be RFC3339."
  }
}

variable "not_before_date" {
  description = "Optional activation date (RFC3339)."
  type        = string
  default     = null

  validation {
    condition = (
      var.not_before_date == null ||
      can(formatdate("", var.not_before_date))
    )

    error_message = "not_before_date must be RFC3339."
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
