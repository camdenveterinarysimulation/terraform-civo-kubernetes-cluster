applications:
%{ for app in applications ~}
  ${app.name}:
    namespace: ${app.argo_namespace}
    additionalLabels: {}
    additionalAnnotations: {}
    project: default
    sources:
      - repoURL: ${app.source_url}
        targetRevision: ${app.target_revision}
        helm:
          valueFiles:
            - $values/${app.name}/values.yaml
        chart: ${app.chart}
      - repoURL: ${app.values_url}
        ref: values
    destination:
      server: https://kubernetes.default.svc
      namespace: ${app.app_namespace}
    syncPolicy:
      automated:
        prune: true
        selfHeal: true
      syncOptions:
      - CreateNamespace=${app.create_namespace}
%{ endfor ~}