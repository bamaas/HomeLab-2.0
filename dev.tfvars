cluster_name = "homelab"

default_gateway = "192.168.8.1"

cluster_endpoint = "https://192.168.8.220:6443"

talos_image = {
  # Image URl gathered from factory.talos.dev
  # Talos bare metal image with QEMU guest agent (and ISCI extension, not available for the bare metal images)
  url = "https://factory.talos.dev/image/88d1f7a5c4f1d3aba7df787c448c1d3d008ed29cfb34af53fa0df4336a56040b/v1.9.5/nocloud-amd64.iso"
  file_name = "talos-1.9.5-nocloud-amd64.iso"
  node_name = "pve"
  datastore_id = "nas-templates"
  overwrite = false
}

node_data = {
  controlplanes = {
    "192.168.8.220" = {
      hostname = "talos-cp-01"
      pve_node = "pve"
      pve_id = 5000
      memory = 4096
      cores = 2
      disk_size = 20
    }
  }
  workers = {
    "192.168.8.230" = {
      hostname = "talos-worker-01"
      pve_node = "pve"
      pve_id = 6000
      memory = 4096
      cores = 2
      disk_size = 20
    }
  }
}