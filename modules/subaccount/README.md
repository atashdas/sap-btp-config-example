# subaccount

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Requirements

| Name | Version |
| ---- | ------- |
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.3.0 |
| <a name="requirement_btp"></a> [btp](#requirement\_btp) | >= 1.0.0 |
| <a name="requirement_random"></a> [random](#requirement\_random) | >= 3.0.0 |

## Providers

| Name | Version |
| ---- | ------- |
| <a name="provider_btp"></a> [btp](#provider\_btp) | >= 1.0.0 |
| <a name="provider_random"></a> [random](#provider\_random) | >= 3.0.0 |

## Modules

No modules.

## Resources

| Name | Type |
| ---- | ---- |
| [btp_subaccount.this](https://registry.terraform.io/providers/SAP/btp/latest/docs/resources/subaccount) | resource |
| [btp_subaccount_role_collection_assignment.user_role_collection_assignment](https://registry.terraform.io/providers/SAP/btp/latest/docs/resources/subaccount_role_collection_assignment) | resource |
| [random_uuid.uuid](https://registry.terraform.io/providers/hashicorp/random/latest/docs/resources/uuid) | resource |
| [btp_globalaccount.this](https://registry.terraform.io/providers/SAP/btp/latest/docs/data-sources/globalaccount) | data source |

## Inputs

| Name | Description | Type | Default | Required |
| ---- | ----------- | ---- | ------- | :------: |
| <a name="input_account_list"></a> [account\_list](#input\_account\_list) | Map of subaccount details | <pre>map(object({<br/>    name        = string<br/>    role        = string<br/>    region      = string<br/>    parent_id   = string<br/>    description = string<br/>    subdomain   = optional(string)<br/>    labels      = optional(map(list(string)))<br/>  }))</pre> | n/a | yes |
| <a name="input_user_role_collection_assignment"></a> [user\_role\_collection\_assignment](#input\_user\_role\_collection\_assignment) | List of User and RoleCollection pairs to be assigned | <pre>map(object({<br/>    account_key          = string<br/>    origin               = optional(string)<br/>    user_name            = string<br/>    role_collection_name = string<br/>  }))</pre> | `{}` | no |

## Outputs

| Name | Description |
| ---- | ----------- |
| <a name="output_account_details"></a> [account\_details](#output\_account\_details) | Output values of the subaccounts created. |
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
