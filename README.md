# CIVO Kubernetes Terraform module

Terraform module which creates CIVO Kubernetes cluster and supporting infrastructure.

## Usage 

```
module "civo_k8s" {
    source  = "shipwright-sh/terraform-civo-k8s"
    version = "0.1"

    cluster_name = "my-cluster"
    region       = "LON1"
    
    cluster_node_count = 3
    cluster_node_size  = "g4s.kube.medium"

    ingress_rule = [
      {
        label      = "k8s"
        protocol   = "tcp"
        port_range = "6443-6443"
        cidr       = ["0.0.0.0/32"]
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
```

## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 0.13 |
| <a name="requirement_civo"></a> [civo](#requirement\_civo) | >= 1.0.18 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_civo"></a> [civo](#provider\_civo) | >= 1.0.18 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [civo_firewall.firewall](https://registry.terraform.io/providers/civo/civo/latest/docs/resources/firewall) | resource |
| [civo_kubernetes_cluster.cluster](https://registry.terraform.io/providers/civo/civo/latest/docs/resources/kubernetes_cluster) | resource |
| [civo_network.network](https://registry.terraform.io/providers/civo/civo/latest/docs/resources/network) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_cluster_name"></a> [cluster\_name](#input\_cluster\_name) | Name of the kubernetes cluster | `string` | n/a | yes |
| <a name="input_cluster_node_count"></a> [cluster\_node\_count](#input\_cluster\_node\_count) | The size of the nodes to provision. Run `civo size list` for all options | `number` | `3` | no |
| <a name="input_cluster_node_size"></a> [cluster\_node\_size](#input\_cluster\_node\_size) | Instance type of the target nodes, choose from `g3.k3s.xsmall`, `g3.k3s.small`, `g3.k3s.medium`, `g3.k3s.large`, `g3.k3s.xlarge`, `g3.k3s.2xlarge` | `string` | `"g3.k3s.medium"` | no |
| <a name="input_cni"></a> [cni](#input\_cni) | CNI Plugin, available options: flannel, cilium | `string` | `"cilium"` | no |
| <a name="input_create_default_rules"></a> [create\_default\_rules](#input\_create\_default\_rules) | Create default firewall rules | `bool` | `false` | no |
| <a name="input_egress_rule"></a> [egress\_rule](#input\_egress\_rule) | Firewall egress rule | <pre>list(object({<br>      label      = string<br>      protocol   = string<br>      port_range = string<br>      cidr       = set(string)<br>      action     = string<br>    }))</pre> | n/a | yes |
| <a name="input_ingress_rule"></a> [ingress\_rule](#input\_ingress\_rule) | Firewall ingress rule | <pre>list(object({<br>      label      = string<br>      protocol   = string<br>      port_range = string<br>      cidr       = set(string)<br>      action     = string<br>    }))</pre> | n/a | yes |
| <a name="input_kubernetes_version"></a> [kubernetes\_version](#input\_kubernetes\_version) | Supported version of the k3s cluster | `string` | `""` | no |
| <a name="input_network_name"></a> [network\_name](#input\_network\_name) | Name of the network | `string` | `""` | no |
| <a name="input_node_label"></a> [node\_label](#input\_node\_label) | Node pool label | `string` | `""` | no |
| <a name="input_region"></a> [region](#input\_region) | The region to provision the cluster against | `string` | `"LON1"` | no |
| <a name="input_tags"></a> [tags](#input\_tags) | Space separated list of tags | `string` | `""` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_api_endpoint"></a> [api\_endpoint](#output\_api\_endpoint) | The API server endpoint of the cluster |
| <a name="output_cluster_id"></a> [cluster\_id](#output\_cluster\_id) | The ID of the cluster |
| <a name="output_kubeconfig"></a> [kubeconfig](#output\_kubeconfig) | The kubeconfig of the cluster |
| <a name="output_master_ip"></a> [master\_ip](#output\_master\_ip) | The IP address of the master node |

## Contributing

We are greatful to the community for contributiong bugfixes and inprovements. Please see below to learn how you can take part.
* Code of Conduct
* Contributing Guide