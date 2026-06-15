# output "dir_l1_dir_configs" {
#   value = local.dir_l1_dir_configs
# }
# output "dir_l2_dir_configs" {
#   value = local.dir_l2_dir_configs
# # }
# output "sa_account_list" {
#   value = local.sa_account_list
# }
# output "directory_list" {
#   value = module.directory.directory_list
# }
# output "sa_ac_user_role_assignmment_list" {
#   value = local.sa_ac_user_role_assignmment_list
# }
# output "ias_svc_custom_idp_host_map" {
#   value = local.ias_svc_custom_idp_host_map
# }
# output "cf_api_url_map" {
#   value = local.cf_api_url_map
# }
output "account_details" {
  description = "Account output values of the subaccounts created."
  value       = local.account_details
}
output "cf_details" {
  description = "Details of all Cloud Foundry instances"
  value       = module.cloudfoundry.cf_details
}
