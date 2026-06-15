output "account_details" {
  description = "Output values of the subaccounts created."
  value = [
    for key, subaccount in btp_subaccount.this : {
      (key) = {
        id              = subaccount.id
        created_by      = subaccount.created_by
        created_date    = subaccount.created_date
        last_modified   = subaccount.last_modified
        parent_features = subaccount.parent_features
        state           = subaccount.state
        subdomain       = local.account_details[key].subdomain
        subaccount_url  = "https://account.hanatrial.ondemand.com/trial/#/globalaccount/${data.btp_globalaccount.this.id}/subaccount/${subaccount.id}"
      }
    }
  ]
}
