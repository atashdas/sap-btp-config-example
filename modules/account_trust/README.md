# account_trust

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
| [btp_subaccount_trust_configuration.this](https://registry.terraform.io/providers/SAP/btp/latest/docs/resources/subaccount_trust_configuration) | resource |

## Inputs

| Name | Description | Type | Default | Required |
| ---- | ----------- | ---- | ------- | :------: |
| <a name="input_trust_configurations"></a> [trust\_configurations](#input\_trust\_configurations) | List of trust config to be applied to subaccount | <pre>map(object({<br/>    subaccount_id     = string<br/>    name              = string<br/>    link_text         = string<br/>    description       = string<br/>    identity_provider = string<br/>  }))</pre> | n/a | yes |

## Outputs

| Name | Description |
| ---- | ----------- |
| <a name="output_trusts"></a> [trusts](#output\_trusts) | Details of all BTP Subaccount Trusts |
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
