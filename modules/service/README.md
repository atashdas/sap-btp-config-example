# service

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
| [btp_subaccount_entitlement.service_application](https://registry.terraform.io/providers/SAP/btp/latest/docs/resources/subaccount_entitlement) | resource |
| [btp_subaccount_role_collection_assignment.user_role_collection_assignment](https://registry.terraform.io/providers/SAP/btp/latest/docs/resources/subaccount_role_collection_assignment) | resource |
| [btp_subaccount_subscription.service_application](https://registry.terraform.io/providers/SAP/btp/latest/docs/resources/subaccount_subscription) | resource |

## Inputs

| Name | Description | Type | Default | Required |
| ---- | ----------- | ---- | ------- | :------: |
| <a name="input_account_service_list"></a> [account\_service\_list](#input\_account\_service\_list) | List of services to be deployed and associated details | <pre>map(object({<br/>    subaccount_id = string<br/>    service_name  = string<br/>    parameters    = string<br/>  }))</pre> | n/a | yes |
| <a name="input_service_list"></a> [service\_list](#input\_service\_list) | Service configuration details. | <pre>map(object({<br/>    service_name      = string<br/>    plan_name         = string<br/>    app_name          = string<br/>    app_name_override = optional(string)<br/>    amount            = optional(number)<br/>  }))</pre> | n/a | yes |
| <a name="input_user_role_assignments"></a> [user\_role\_assignments](#input\_user\_role\_assignments) | Service Role Collections to be assigned to users at subaccount level | <pre>map(object({<br/>    role_collection_name = string<br/>    subaccount_id        = string<br/>    user_name            = string<br/>    origin               = optional(string)<br/>  }))</pre> | `{}` | no |

## Outputs

| Name | Description |
| ---- | ----------- |
| <a name="output_custom_identity_provider_host_map"></a> [custom\_identity\_provider\_host\_map](#output\_custom\_identity\_provider\_host\_map) | Custom Identity Provider Hosts to be used for nmominated accounts |
| <a name="output_svc_applications"></a> [svc\_applications](#output\_svc\_applications) | Service Applications |
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
