locals {
  applications = [
    for k, v in var.applications : {
      name             = k
      create_namespace = v.create_namespace
      argo_namespace   = v.argo_namespace
      app_namespace    = v.app_namespace
      source_url       = v.source_url
      values_url       = v.values_url
      target_revision  = v.target_revision
      chart            = v.chart
    }
  ]
}

resource "kubernetes_namespace" "argocd" {
  metadata {
    name = var.namespace
  }
}

module helm_chart_argocd {
  source  = "terraform-module/release/helm"
  version = "2.6.0"

  namespace  = var.namespace
  repository = "https://argoproj.github.io/argo-helm"

  app = {
    name          = var.name
    chart         = "argo-cd"
    version       = var.chart_version
    force_update  = true
    wait          = false
    recreate_pods = false
    deploy        = 1
  }

  set = []

  set_sensitive = []

  values = compact([
    # standard k8s object settings
    yamlencode({
      fullnameOverride = var.name,
      redis-ha = {
        enabled = var.redis_ha_enabled
      },
      controller = {
        replicas = var.controller_replicas
      },
      server = {
        autoscaling = {
          enabled = var.server_autoscaling_enabled
          minReplicas = var.server_autoscaling_min_replicas
        }
      },
      repoServer = {
        autoscaling = {
          enabled = var.reposerver_autoscaling_enabled
          minReplicas = var.reposerver_autoscaling_min_replicas
        }
      },
      applicationSet = {
        replicas = var.applicationset_relicas
      },
      resources = var.resources
    }),
    # hardcoded values
    yamlencode(var.chart_values)
  ])
}

module helm_chart_argocd_apps {
  source  = "terraform-module/release/helm"
  version = "2.8.2"

  namespace  = "argocd"
  repository = "https://argoproj.github.io/argo-helm"

  app = {
    name          = "argocd-apps"
    version       = var.argocd_apps_chart_version
    chart         = "argocd-apps"
    force_update  = true
    wait          = false
    recreate_pods = false
    deploy        = 1
  }

  set = []

  values = [
    templatefile("${path.module}/resources/argocd-apps-values.yaml.tpl", {
      applications = local.applications
    })
  ]
  depends_on = [
    module.helm_chart_argocd,
    kubernetes_namespace.argocd
  ]
}