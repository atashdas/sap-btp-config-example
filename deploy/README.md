# deploy

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Requirements

| Name | Version |
| ---- | ------- |
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.3.0 |
| <a name="requirement_btp"></a> [btp](#requirement\_btp) | >= 1.0.0 |
| <a name="requirement_cloudfoundry"></a> [cloudfoundry](#requirement\_cloudfoundry) | >=1.3.0 |

## Providers

| Name | Version |
| ---- | ------- |
| <a name="provider_btp"></a> [btp](#provider\_btp) | 1.23.1 |

## Modules

| Name | Source | Version |
| ---- | ------ | ------- |
| <a name="module_account_trust_configurations"></a> [account\_trust\_configurations](#module\_account\_trust\_configurations) | ../modules/account_trust | n/a |
| <a name="module_cloudfoundry"></a> [cloudfoundry](#module\_cloudfoundry) | ../modules/cloudfoundry | n/a |
| <a name="module_cloudfoundry_org_ap21"></a> [cloudfoundry\_org\_ap21](#module\_cloudfoundry\_org\_ap21) | ../modules/cloudfoundry_org | n/a |
| <a name="module_cloudfoundry_org_us10"></a> [cloudfoundry\_org\_us10](#module\_cloudfoundry\_org\_us10) | ../modules/cloudfoundry_org | n/a |
| <a name="module_cloudfoundry_space_ap21"></a> [cloudfoundry\_space\_ap21](#module\_cloudfoundry\_space\_ap21) | ../modules/cloudfoundry_space | n/a |
| <a name="module_cloudfoundry_space_us10"></a> [cloudfoundry\_space\_us10](#module\_cloudfoundry\_space\_us10) | ../modules/cloudfoundry_space | n/a |
| <a name="module_directory"></a> [directory](#module\_directory) | ../modules/directory | n/a |
| <a name="module_identity_services"></a> [identity\_services](#module\_identity\_services) | ../modules/service | n/a |
| <a name="module_other_services"></a> [other\_services](#module\_other\_services) | ../modules/service | n/a |
| <a name="module_subaccount"></a> [subaccount](#module\_subaccount) | ../modules/subaccount | n/a |

## Resources

| Name | Type |
| ---- | ---- |
| [btp_globalaccount.this](https://registry.terraform.io/providers/SAP/btp/latest/docs/data-sources/globalaccount) | data source |

## Inputs

| Name | Description | Type | Default | Required |
| ---- | ----------- | ---- | ------- | :------: |
| <a name="input_config_file"></a> [config\_file](#input\_config\_file) | The S3 key for the config file. | `string` | `"desired_config.json"` | no |

## Outputs

| Name | Description |
| ---- | ----------- |
| <a name="output_account_details"></a> [account\_details](#output\_account\_details) | Account output values of the subaccounts created. |
| <a name="output_cf_details"></a> [cf\_details](#output\_cf\_details) | Details of all Cloud Foundry instances |
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
