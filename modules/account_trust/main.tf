resource "btp_subaccount_trust_configuration" "this" {
  for_each = var.trust_configurations

  name              = each.value.name
  description       = each.value.description
  link_text         = each.value.link_text
  subaccount_id     = each.value.subaccount_id
  identity_provider = each.value.identity_provider
}
