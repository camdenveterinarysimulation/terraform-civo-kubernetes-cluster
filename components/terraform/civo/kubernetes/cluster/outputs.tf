#output "kubeconfig" {
#  value       = civo_kubernetes_cluster.cluster.kubeconfig
#  description = "The kubeconfig of the cluster"
#}

output "master_ip" {
  value       = civo_kubernetes_cluster.cluster.master_ip
  description = "The IP address of the master node"
}

output "cluster_id" {
  value       = civo_kubernetes_cluster.cluster.id
  description = "The ID of the cluster"
}

output "api_endpoint" {
  value       = civo_kubernetes_cluster.cluster.api_endpoint
  description = "The API server endpoint of the cluster"
}