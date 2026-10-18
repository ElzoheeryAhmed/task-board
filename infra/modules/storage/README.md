<!-- BEGIN_TF_DOCS -->
## Requirements

No requirements.

## Providers

| Name | Version |
|------|---------|
| <a name="provider_kubernetes"></a> [kubernetes](#provider\_kubernetes) | 3.3.0 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [kubernetes_storage_class_v1.gp3](https://registry.terraform.io/providers/hashicorp/kubernetes/latest/docs/resources/storage_class_v1) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_encrypted"></a> [encrypted](#input\_encrypted) | n/a | `bool` | `true` | no |
| <a name="input_fs_type"></a> [fs\_type](#input\_fs\_type) | n/a | `string` | `"ext4"` | no |
| <a name="input_name"></a> [name](#input\_name) | n/a | `string` | `"gp3"` | no |
| <a name="input_reclaim_policy"></a> [reclaim\_policy](#input\_reclaim\_policy) | n/a | `string` | `"Retain"` | no |
| <a name="input_volume_type"></a> [volume\_type](#input\_volume\_type) | n/a | `string` | `"gp3"` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_storage_class_name"></a> [storage\_class\_name](#output\_storage\_class\_name) | n/a |
<!-- END_TF_DOCS -->