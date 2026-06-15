output "cf_details" {
  description = "Details of all Cloud Foundry instances"
  value = merge(flatten([
    for key, cf in btp_subaccount_environment_instance.this : {
      (key) = {
        broker_id          = cf.broker_id
        created_date       = cf.created_date
        custom_labels      = cf.custom_labels
        dashboard_url      = cf.dashboard_url
        description        = cf.description
        id                 = cf.id
        labels             = cf.labels
        last_modified      = cf.last_modified
        operation          = cf.operation
        plan_id            = cf.plan_id
        platform_id        = cf.platform_id
        service_id         = cf.service_id
        state              = cf.state
        cf_api_url         = jsondecode(cf.labels)["API Endpoint"]
        cf_org_name        = jsondecode(cf.labels)["Org Name"]
        cf_org_id          = jsondecode(cf.labels)["Org ID"]
        cf_landscape_label = cf.landscape_label
      }
    }
  ])...)
}

output "cf_orgs" {
  description = "Cloud Foundry Org IDs"
  value = merge(flatten([
    for cf in btp_subaccount_environment_instance.this : {
      (jsondecode(cf.labels)["Org Name"]) = jsondecode(cf.labels)["Org ID"]
    }
  ])...)
}
