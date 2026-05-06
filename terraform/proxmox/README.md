<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
| ---- | ------- |
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.6 |
| <a name="requirement_proxmox"></a> [proxmox](#requirement\_proxmox) | ~> 0.50 |

## Providers

| Name | Version |
| ---- | ------- |
| <a name="provider_proxmox"></a> [proxmox](#provider\_proxmox) | 0.99.0 |

## Modules

No modules.

## Resources

| Name | Type |
| ---- | ---- |
| [proxmox_virtual_environment_vm.k3s_vms](https://registry.terraform.io/providers/bpg/proxmox/latest/docs/resources/virtual_environment_vm) | resource |

## Inputs

| Name | Description | Type | Default | Required |
| ---- | ----------- | ---- | ------- | :------: |
| <a name="input_proxmox_node"></a> [proxmox\_node](#input\_proxmox\_node) | Proxmox node name | `string` | `"proxmox"` | no |
| <a name="input_proxmox_token_id"></a> [proxmox\_token\_id](#input\_proxmox\_token\_id) | Proxmox API token ID | `string` | n/a | yes |
| <a name="input_proxmox_token_secret"></a> [proxmox\_token\_secret](#input\_proxmox\_token\_secret) | Proxmox API token secret | `string` | n/a | yes |
| <a name="input_proxmox_url"></a> [proxmox\_url](#input\_proxmox\_url) | Proxmox API URL | `string` | n/a | yes |
| <a name="input_ssh_public_key"></a> [ssh\_public\_key](#input\_ssh\_public\_key) | SSH public key to inject into VMs | `string` | n/a | yes |
| <a name="input_template_vm_id"></a> [template\_vm\_id](#input\_template\_vm\_id) | VM ID of the Packer-built template to clone | `number` | `9000` | no |

## Outputs

| Name | Description |
| ---- | ----------- |
| <a name="output_first_server_ip"></a> [first\_server\_ip](#output\_first\_server\_ip) | IP of the first server node (used for cluster-init) |
| <a name="output_server_ips"></a> [server\_ips](#output\_server\_ips) | k3s server node IPs |
<!-- END_TF_DOCS -->
