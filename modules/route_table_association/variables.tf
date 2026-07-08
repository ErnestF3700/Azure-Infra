variable "subnet_id" {
  description = "Resource ID of the Azure subnet to associate with the Route Table."
  type        = string
  nullable    = false

  validation {
    condition = can(regex(
      "(?i)^/subscriptions/[0-9a-f]{8}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{12}/resourceGroups/[^/]+/providers/Microsoft\\.Network/virtualNetworks/[^/]+/subnets/[^/]+$",
      var.subnet_id
    ))
    error_message = "The subnet_id must be a valid Azure subnet resource ID in the form `/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Network/virtualNetworks/{virtualNetworkName}/subnets/{subnetName}`."
  }
}

variable "route_table_id" {
  description = "Resource ID of the Azure Route Table to associate with the subnet."
  type        = string
  nullable    = false

  validation {
    condition = can(regex(
      "(?i)^/subscriptions/[0-9a-f]{8}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{12}/resourceGroups/[^/]+/providers/Microsoft\\.Network/routeTables/[^/]+$",
      var.route_table_id
    ))
    error_message = "The route_table_id must be a valid Azure Route Table resource ID in the form `/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Network/routeTables/{routeTableName}`."
  }
}
