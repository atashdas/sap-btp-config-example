# Create a parent directory with requested features enabled
resource "btp_directory" "l1" {
  for_each = var.l1_directories

  name        = each.value.name
  description = each.value.description
  features    = each.value.feature

  labels = merge({
    name = [each.value.name]
  }, each.value.labels)
}

# Create child directories underneath a parent directory with features enabled
resource "btp_directory" "l2" {
  for_each = var.l2_directories

  name        = each.value.name
  description = each.value.description
  features    = each.value.feature
  parent_id   = btp_directory.l1[each.value.parent_name].id

  labels = merge({
    name = [each.value.name]
  }, each.value.labels)

  depends_on = [btp_directory.l1]
}
