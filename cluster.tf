resource "civo_kubernetes_cluster" "cluster" {
  count = var.cluster != "" ? 0 : 1

  name               = var.cluster_name
  kubernetes_version = var.kubernetes_version

  network_id  = civo_network.network[0].id
  firewall_id = civo_firewall.firewall[0].id

  region = var.region
  cni    = var.cni

  dynamic "node_pool" {
    for_each = var.node_pool
    pools {
      label      = node_pool.value.label
      node_count = node_pool.value.label
      size       = node_pool.value.label
    }
  }

  tags = var.tags
}