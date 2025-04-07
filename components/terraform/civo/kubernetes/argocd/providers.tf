provider "helm" {
  kubernetes {
    config_path = "~/.kube/civo-vem-development-cluster-kubeconfig"
    #config_context = var.context
  }
}

provider "kubernetes" {
  config_path = "~/.kube/civo-vem-development-cluster-kubeconfig"
  #config_context = var.context
}