resource "civo_network" "network" {
  count = var.network_name != "" ? 0 : 1
  label = "${var.cluster_name}-network"
}