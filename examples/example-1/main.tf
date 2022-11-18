terraform {
  required_providers {
    civo = {
      source = "civo/civo"
      version = ">= 1.0.7"
    }
  }
}

variable "civo_token" {}

provider "civo" {
  token = var.civo_token
  region = local.region
}

locals {
  region = "LON1"
}

module "civo_k8s" {
    source = "../../"
    cluster_name = "poc-lon1-1"
    node_label   = "Terraform"
    region       = "LON1"
    
    cluster_node_count = 3
    cluster_node_size  = "g4s.kube.medium"

    ingress_rule = [
      {
        label      = "k8s"
        protocol   = "tcp"
        port_range = "6443-6443"
        cidr       = ["80.195.132.204/32"]
        action     = "allow"
      }
    ]

    egress_rule = [
      {
        label      = "all"
        protocol   = "tcp"
        port_range = "1-65535"
        cidr       = ["0.0.0.0/0"]
        action     = "allow"
      }
    ]
}