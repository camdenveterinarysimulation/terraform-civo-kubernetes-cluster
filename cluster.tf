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