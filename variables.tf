variable "cluster_name" {
    type = string
    description = "name of the kubernetes cluster"
}

variable "node_count" {
  type = number
  description = "number of target nodes"
  default = 3
}

variable "node_size" {
    type = string
    description = "instance type of the target nodes, choose from `g3.k3s.xsmall`, `g3.k3s.small`, `g3.k3s.medium`, `g3.k3s.large`, `g3.k3s.xlarge`, `g3.k3s.2xlarge`"
    default = "g3.k3s.medium"
  
}

variable "kubernetes_version" {
    type = string
    description = "Supported version of the k3s cluster"
    default = ""
}

variable "network_name" {
    type = string
    description = "Name of the existing network"
    default = ""
}

variable "firewall_name" {
    type = string
    description = "name of the existing firewall"
    default = ""
}

variable "ingress_rule" {
    type = list(object({
      label      = string
      protocol   = string
      port_range = string
      cidr       = set(string)
      action     = string
    }))
    description = "name of the existing firewall"
}

variable "egress_rule" {
    type = list(object({
      label      = string
      protocol   = string
      port_range = string
      cidr       = set(string)
      action     = string
    }))
    description = "name of the existing firewall"
}

variable "create_default_rules" {
    type = bool
    description = "Create default firewall rules"
    default = false
}

variable "cni" {
    type = string
    description = "CNI Plugin, available options: flannel, cilium"
    default = "cilium"
}

variable "tags" {
    type = string
    description = "Space separated list of tags"
    default = ""
}

variable "region" {
    type = string
    description = "Region for the Cluster"
}

variable "node_label" {
    type = string
    description = "(optional) describe your variable"
}