terraform {
  required_version = ">= 0.13"
  required_providers {
    civo = {
      source  = "civo/civo"
      version = ">= 1.0.18"
    }
  }
}

provider "civo" {
  token = var.civo_token
  region = var.region
}

resource "civo_network" "network" {
  count = var.network_name != "" ? 0 : 1
  label = "${var.cluster_name}-network"
}

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

resource "civo_kubernetes_cluster" "cluster" {
  name               = var.cluster_name
  kubernetes_version = var.kubernetes_version

  network_id  = civo_network.network[0].id
  firewall_id = civo_firewall.firewall.id

  region = var.region
  cni    = var.cni

  pools {
    node_count = var.cluster_node_count
    size       = var.cluster_node_size
  }

  tags = var.tags
}