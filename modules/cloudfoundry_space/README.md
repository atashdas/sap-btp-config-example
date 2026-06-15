# cloudfoundry_space

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
| [cloudfoundry_space.space](https://registry.terraform.io/providers/cloudfoundry/cloudfoundry/latest/docs/resources/space) | resource |
| [cloudfoundry_space_role.space_auditors](https://registry.terraform.io/providers/cloudfoundry/cloudfoundry/latest/docs/resources/space_role) | resource |
| [cloudfoundry_space_role.space_developers](https://registry.terraform.io/providers/cloudfoundry/cloudfoundry/latest/docs/resources/space_role) | resource |
| [cloudfoundry_space_role.space_managers](https://registry.terraform.io/providers/cloudfoundry/cloudfoundry/latest/docs/resources/space_role) | resource |
| [cloudfoundry_space_role.space_supporters](https://registry.terraform.io/providers/cloudfoundry/cloudfoundry/latest/docs/resources/space_role) | resource |

## Inputs

| Name | Description | Type | Default | Required |
| ---- | ----------- | ---- | ------- | :------: |
| <a name="input_cf_space_config_parameters"></a> [cf\_space\_config\_parameters](#input\_cf\_space\_config\_parameters) | Configuration Parameters for Cloudfoundry Space | <pre>map(object({<br/>    cf_region = string<br/>    name      = string<br/>    org_id    = string<br/>    org_name  = string<br/>    auditors = object({<br/>      origin = optional(string),<br/>      users  = list(string)<br/>    })<br/>    developers = object({<br/>      origin = optional(string),<br/>      users  = list(string)<br/>    })<br/>    managers = object({<br/>      origin = optional(string),<br/>      users  = list(string)<br/>    })<br/>    supporters = object({<br/>      origin = optional(string),<br/>      users  = list(string)<br/>    })<br/>  }))</pre> | n/a | yes |
| <a name="input_labels"></a> [labels](#input\_labels) | List of labels to be applied to new space | `map(string)` | `{}` | no |

## Outputs

| Name | Description |
| ---- | ----------- |
| <a name="output_space_id"></a> [space\_id](#output\_space\_id) | ID of the Cloudfoundry space. |
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
