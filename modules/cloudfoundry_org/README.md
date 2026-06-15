# cloudfoundry_org

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Requirements

| Name | Version |
| ---- | ------- |
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.3.0 |
| <a name="requirement_cloudfoundry"></a> [cloudfoundry](#requirement\_cloudfoundry) | >=1.3.0 |

## Providers

| Name | Version |
| ---- | ------- |
| <a name="provider_cloudfoundry"></a> [cloudfoundry](#provider\_cloudfoundry) | >=1.3.0 |

## Modules

No modules.

## Resources

| Name | Type |
| ---- | ---- |
| [cloudfoundry_org_role.org_auditors](https://registry.terraform.io/providers/cloudfoundry/cloudfoundry/latest/docs/resources/org_role) | resource |
| [cloudfoundry_org_role.org_managers](https://registry.terraform.io/providers/cloudfoundry/cloudfoundry/latest/docs/resources/org_role) | resource |
| [cloudfoundry_org_role.org_users](https://registry.terraform.io/providers/cloudfoundry/cloudfoundry/latest/docs/resources/org_role) | resource |

## Inputs

| Name | Description | Type | Default | Required |
| ---- | ----------- | ---- | ------- | :------: |
| <a name="input_cf_org_config_parameters"></a> [cf\_org\_config\_parameters](#input\_cf\_org\_config\_parameters) | Configuration Parameters for Cloudfoundry org | <pre>map(object({<br/>    cf_region = string<br/>    id        = string<br/>    auditors = object({<br/>      origin = optional(string)<br/>      users  = list(string)<br/>    })<br/>    managers = object({<br/>      origin = optional(string)<br/>      users  = list(string)<br/>    })<br/>    users = object({<br/>      origin = optional(string)<br/>      users  = list(string)<br/>    })<br/>  }))</pre> | n/a | yes |

## Outputs

No outputs.
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
