terraform {
  required_version = ">= 0.13"
  required_providers {
    civo = {
      source  = "civo/civo"
      version = ">= 1.1.5"
    }
  }
}

provider "civo" {
  token = var.civo_token
  region = var.region
}

resource "civo_network" "network" {
  label = "${var.name}-${var.stage}-network"
}

resource "civo_firewall" "firewall" {
  name                 = "${var.name}-${var.stage}-firewall"
  network_id           = civo_network.network.id
  create_default_rules = var.create_default_rules
}

resource "civo_kubernetes_cluster" "cluster" {
  name               = "${var.name}-${var.stage}-cluster"
  kubernetes_version = var.kubernetes_version

  network_id  = civo_network.network.id
  firewall_id = civo_firewall.firewall.id

  region = var.region
  cni    = var.cni

  pools {
    node_count = var.cluster_node_count
    size       = var.cluster_node_size
  }

  tags = var.tags
}