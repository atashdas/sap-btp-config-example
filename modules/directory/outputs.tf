output "directory_list" {
  description = "List of all directories"
  value       = merge(btp_directory.l1, btp_directory.l2)
}
