cluster_name = "dev"

default_gateway = "192.168.8.1"

cluster_endpoint = "https://192.168.8.220:6443"

virtual_shared_ip = "192.168.8.99"

cluster_domain = "kubernetes.lan.basmaas.nl"

talos_image = {
  # Image URl gathered from factory.talos.dev
  # Talos cloud image (nocloud).
  # customization:
  #   systemExtensions:
  #       officialExtensions:
  #           - siderolabs/iscsi-tools
  #           - siderolabs/qemu-guest-agent
  #           - siderolabs/util-linux-tools
  url          = "https://factory.talos.dev/image/613e1592b2da41ae5e265e8789429f22e121aab91cb4deb6bc3c0b6262961245/v1.10.3/nocloud-amd64.iso"
  file_name    = "talos-1.10.3-nocloud-amd64.iso"
  node_name    = "pve"
  datastore_id = "nas-templates"
  overwrite    = false
}

node_data = {
  controlplanes = {
    "192.168.8.220" = {
      hostname  = "talos-cp-01"
      pve_node  = "pve"
      pve_id    = 5000
      memory    = 4096
      cores     = 2
      disk_size = 20
    }
  }
  workers = {
    "192.168.8.230" = {
      hostname  = "talos-worker-01"
      pve_node  = "pve"
      pve_id    = 6000
      memory    = 4096
      cores     = 2
      disk_size = 20
    }
  }
}