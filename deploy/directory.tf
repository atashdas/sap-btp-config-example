locals {
  dir_l1_dir_configs = merge(flatten([
    for l1_key, l1_dir in lookup(try(local.config_data.landscape, {}), "directories", {}) : {
      (l1_key) = {
        name        = l1_key
        description = l1_dir.description
        feature     = l1_dir.feature
        parent_name = ""
        labels      = merge(local.btp_global_labels, try(l1_dir.labels, null) != null ? { for k, v in l1_dir.labels : k => [v] } : {})
      }
    }
  ])...)

  dir_l2_dir_configs = merge(flatten([
    for l1_key, l1_dir in lookup(try(local.config_data.landscape, {}), "directories", {}) : [
      for l2_key, l2_dir in lookup(l1_dir, "directories", {}) : {
        (format("%s>%s", l1_key, l2_key)) = {
          name        = l2_key
          description = l2_dir.description
          feature     = l2_dir.feature
          parent_name = l1_key
          labels      = merge(local.btp_global_labels, try(l2_dir.labels, null) != null ? { for k, v in l2_dir.labels : k => [v] } : {})
        }
      }
    ]
  ])...)
}

module "directory" {
  source = "../modules/directory"

  l1_directories = local.dir_l1_dir_configs
  l2_directories = local.dir_l2_dir_configs
}
