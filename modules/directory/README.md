# directory

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Requirements

| Name | Version |
| ---- | ------- |
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.3.0 |
| <a name="requirement_btp"></a> [btp](#requirement\_btp) | >= 1.0.0 |

## Providers

| Name | Version |
| ---- | ------- |
| <a name="provider_btp"></a> [btp](#provider\_btp) | >= 1.0.0 |

## Modules

No modules.

## Resources

| Name | Type |
| ---- | ---- |
| [btp_directory.l1](https://registry.terraform.io/providers/SAP/btp/latest/docs/resources/directory) | resource |
| [btp_directory.l2](https://registry.terraform.io/providers/SAP/btp/latest/docs/resources/directory) | resource |

## Inputs

| Name | Description | Type | Default | Required |
| ---- | ----------- | ---- | ------- | :------: |
| <a name="input_l1_directories"></a> [l1\_directories](#input\_l1\_directories) | List of level 1 directories | <pre>map(object({<br/>    name        = string<br/>    description = string<br/>    feature     = list(string)<br/>    parent_name = string<br/>    labels      = map(list(string))<br/>  }))</pre> | n/a | yes |
| <a name="input_l2_directories"></a> [l2\_directories](#input\_l2\_directories) | List of level 2 directories | <pre>map(object({<br/>    name        = string<br/>    description = string<br/>    feature     = list(string)<br/>    parent_name = string<br/>    labels      = map(list(string))<br/>  }))</pre> | n/a | yes |

## Outputs

| Name | Description |
| ---- | ----------- |
| <a name="output_directory_list"></a> [directory\_list](#output\_directory\_list) | List of all directories |
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
