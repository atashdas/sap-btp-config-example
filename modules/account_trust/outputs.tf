output "trusts" {
  description = "Details of all BTP Subaccount Trusts"
  value = merge(flatten([
    for trust in btp_subaccount_trust_configuration.this : {
      (trust.subaccount_id) = {
        id        = trust.id
        origin    = trust.origin
        protocol  = trust.protocol
        read_only = trust.read_only
        type      = trust.type
      }
    }
  ])...)
}
