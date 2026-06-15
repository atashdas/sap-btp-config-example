output "space_id" {
  description = "ID of the Cloudfoundry space."
  value = merge(flatten([
    for key, space in cloudfoundry_space.space : {
      (key) = {
        id = space.id
      }
    }
  ])...)
  # value       = local.space_id
}
