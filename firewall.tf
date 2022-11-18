resource "civo_firewall" "firewall" {
  name                 = "${var.cluster_name}-firewall"
  network_id           = civo_network.network[0].id
  create_default_rules = var.create_default_rules
  
  dynamic "ingress_rule" {
    for_each = var.ingress_rule
    content {
      label      = ingress_rule.value.label
      protocol   = ingress_rule.value.protocol
      port_range = ingress_rule.value.port_range
      cidr       = ingress_rule.value.cidr
      action     = ingress_rule.value.action
    }
  }

  dynamic "egress_rule" {
    for_each = var.egress_rule
    content {
      label      = egress_rule.value.label
      protocol   = egress_rule.value.protocol
      port_range = egress_rule.value.port_range
      cidr       = egress_rule.value.cidr
      action     = egress_rule.value.action
    }
  }
}