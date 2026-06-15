# output "svc_cfg" {
#   description = "Service Configuration"
#   value       = local.svc_cfg
# }

# output "svc_instances" {
#   description = "Service Instances"
#   value       = local.svc_instances
# }

output "svc_applications" {
  description = "Service Applications"
  value       = local.svc_applications
}

output "custom_identity_provider_host_map" {
  description = "Custom Identity Provider Hosts to be used for nmominated accounts"
  value = merge(flatten([
    for svcKey, svcOutput in btp_subaccount_subscription.service_application : {
      (svcKey) = {
        "host" : try(trimsuffix(trimprefix(svcOutput.subscription_url, "https://"), "/admin"), "")
      }
    } if endswith(svcKey, ":identity-default-service") == true
  ])...)
}
