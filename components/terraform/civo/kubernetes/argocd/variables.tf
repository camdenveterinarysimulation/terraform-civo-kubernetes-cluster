variable "stage" {
  type = string
}

variable "context" {
  type = string
  default = null
}

variable "name" {
  type = string
}

variable "namespace" {
  type = string
}

variable "chart_version" {
  type = string
}

variable "argocd_apps_chart_version" {
  type = string
}

variable "chart_values" {
  type        = any
  default     = {}
}

variable "resources" {
  type = object({
    limits = object({
      cpu    = string
      memory = string
    })
    requests = object({
      cpu    = string
      memory = string
    })
  })
  default = {
    limits = {
      cpu    = "200m"
      memory = "256Mi"
    },
    requests = {
      cpu    = "100m"
      memory = "128Mi"
    }
  }
}

variable "redis_ha_enabled" {
  type = string
}

variable "controller_replicas" {
  type = number
}

variable "server_autoscaling_enabled" {
  type = bool
}

variable "server_autoscaling_min_replicas" {
  type = number
}

variable "reposerver_autoscaling_enabled" {
  type = bool
}

variable "reposerver_autoscaling_min_replicas" {
  type = number
}

variable "applicationset_relicas" {
  type = number
}

variable "applications" {
  type = any
  default = {}
}