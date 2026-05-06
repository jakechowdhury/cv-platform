<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
| ---- | ------- |
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.6 |
| <a name="requirement_cloudflare"></a> [cloudflare](#requirement\_cloudflare) | ~> 4.0 |

## Providers

| Name | Version |
| ---- | ------- |
| <a name="provider_cloudflare"></a> [cloudflare](#provider\_cloudflare) | 4.52.7 |
| <a name="provider_random"></a> [random](#provider\_random) | 3.8.1 |

## Modules

No modules.

## Resources

| Name | Type |
| ---- | ---- |
| [cloudflare_record.cv_site](https://registry.terraform.io/providers/cloudflare/cloudflare/latest/docs/resources/record) | resource |
| [cloudflare_zero_trust_tunnel_cloudflared.cv_site](https://registry.terraform.io/providers/cloudflare/cloudflare/latest/docs/resources/zero_trust_tunnel_cloudflared) | resource |
| [cloudflare_zero_trust_tunnel_cloudflared_config.cv_site](https://registry.terraform.io/providers/cloudflare/cloudflare/latest/docs/resources/zero_trust_tunnel_cloudflared_config) | resource |
| [random_password.tunnel_secret](https://registry.terraform.io/providers/hashicorp/random/latest/docs/resources/password) | resource |
| [cloudflare_zones.cv_site](https://registry.terraform.io/providers/cloudflare/cloudflare/latest/docs/data-sources/zones) | data source |

## Inputs

| Name | Description | Type | Default | Required |
| ---- | ----------- | ---- | ------- | :------: |
| <a name="input_cloudflare_account_id"></a> [cloudflare\_account\_id](#input\_cloudflare\_account\_id) | Cloudflare account ID | `string` | n/a | yes |
| <a name="input_cloudflare_api_token"></a> [cloudflare\_api\_token](#input\_cloudflare\_api\_token) | Cloudflare API token with Zone:DNS:Edit and Tunnel:Edit permissions | `string` | n/a | yes |
| <a name="input_cloudflare_zone_name"></a> [cloudflare\_zone\_name](#input\_cloudflare\_zone\_name) | Cloudflare zone name | `string` | `"jakechowdhury.co.uk"` | no |

## Outputs

| Name | Description |
| ---- | ----------- |
| <a name="output_tunnel_token"></a> [tunnel\_token](#output\_tunnel\_token) | n/a |
<!-- END_TF_DOCS -->
