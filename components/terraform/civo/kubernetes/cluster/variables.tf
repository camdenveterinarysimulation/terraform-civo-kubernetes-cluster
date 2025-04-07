variable "civo_token" {
  type        = string
  description = "A token used for authentication."
}

variable "stage" {
  type        = string
  default     = null
  description = "ID element. Usually used to indicate role, e.g. 'prod', 'staging', 'source', 'build', 'test', 'deploy', 'release'"
}

variable "region" {
  type        = string
  default     = "LON1"
  description = "The region to provision the cluster against"
}

variable "name" {
  type        = string
  description = "Name of the kubernetes cluster"
}

variable "kubernetes_version" {
  type        = string
  description = "Supported version of the k3s cluster"
  default     = ""
}

variable "cluster_node_count" {
  type        = number
  default     = 3
  description = "The size of the nodes to provision. Run `civo size list` for all options"
}

variable "cluster_node_size" {
  type        = string
  description = "Instance type of the target nodes, choose from `g3.k3s.xsmall`, `g3.k3s.small`, `g3.k3s.medium`, `g3.k3s.large`, `g3.k3s.xlarge`, `g3.k3s.2xlarge`"
  default     = "g3.k3s.medium"
}

variable "network_name" {
  type        = string
  description = "Name of the network"
  default     = ""
}

variable "ingress_rule" {
  type = list(object({
    label      = string
    protocol   = string
    port_range = string
    cidr       = set(string)
    action     = string
  }))
  description = "Firewall ingress rule"
  default = []
}

variable "egress_rule" {
  type = list(object({
    label      = string
    protocol   = string
    port_range = string
    cidr       = set(string)
    action     = string
  }))
  description = "Firewall egress rule"
  default = []
}

variable "create_default_rules" {
  type        = bool
  description = "Create default firewall rules"
  default     = false
}

variable "cni" {
  type        = string
  description = "CNI Plugin, available options: flannel, cilium"
  default     = "cilium"
}

variable "tags" {
  type        = string
  description = "Space separated list of tags"
  default     = ""
}

variable "node_label" {
  type        = string
  description = "Node pool label"
  default     = ""
}