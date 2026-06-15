# output "org_id" {
#   description = "ID of the Cloudfoundry Organization."
#   value = merge(flatten([
#     for key, org in data.cloudfoundry_org.org : {
#       (key) = {
#         id = org.id
#       }
#     }
#   ])...)
#   # value       = local.org_id
# }
