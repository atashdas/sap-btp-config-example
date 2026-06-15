# cloudfoundry

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
| <a name="provider_terraform"></a> [terraform](#provider\_terraform) | n/a |

## Modules

No modules.

## Resources

| Name | Type |
| ---- | ---- |
| [btp_subaccount_environment_instance.this](https://registry.terraform.io/providers/SAP/btp/latest/docs/resources/subaccount_environment_instance) | resource |
| [terraform_data.cf_landscape_label](https://registry.terraform.io/providers/hashicorp/terraform/latest/docs/resources/data) | resource |
| [btp_subaccount_environments.all](https://registry.terraform.io/providers/SAP/btp/latest/docs/data-sources/subaccount_environments) | data source |

## Inputs

| Name | Description | Type | Default | Required |
| ---- | ----------- | ---- | ------- | :------: |
| <a name="input_cloudfoundry_list"></a> [cloudfoundry\_list](#input\_cloudfoundry\_list) | List of CF environments | <pre>map(object({<br/>    account_key        = string<br/>    account_id         = string<br/>    account_region     = string<br/>    cf_landscape_label = string<br/>    cf_name            = string<br/>    cf_parameters = object({<br/>      instance_name = string<br/>    })<br/>    cf_plan_name = string<br/>  }))</pre> | n/a | yes |

## Outputs

| Name | Description |
| ---- | ----------- |
| <a name="output_cf_details"></a> [cf\_details](#output\_cf\_details) | Details of all Cloud Foundry instances |
| <a name="output_cf_orgs"></a> [cf\_orgs](#output\_cf\_orgs) | Cloud Foundry Org IDs |
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
