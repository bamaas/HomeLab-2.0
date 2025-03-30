resource "proxmox_virtual_environment_download_file" "talos_image" {
  content_type            = var.talos_image.content_type
  datastore_id            = var.talos_image.datastore_id
  file_name               = var.talos_image.file_name
  node_name               = var.talos_image.node_name
  url                     = var.talos_image.url
  overwrite               = var.talos_image.overwrite
}