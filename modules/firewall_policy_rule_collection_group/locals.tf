locals {
  name               = trimspace(var.name)
  firewall_policy_id = trimspace(var.firewall_policy_id)
  priority           = var.priority

  application_rule_collections = var.application_rule_collections
  network_rule_collections     = var.network_rule_collections
  nat_rule_collections         = var.nat_rule_collections
}
