variable "default_gateway" {
  description = "IP address of your default gateway"
  type        = string
}

variable "cluster_name" {
  description = "A name to provide for the Talos cluster"
  type        = string
}

variable "cluster_endpoint" {
  description = "The endpoint for the Talos cluster"
  type        = string
}

variable "virtual_shared_ip" {
  description = "The virtual shared IP address for the cluster control plane nodes"
  type        = string
}

variable "cluster_domain" {
  description = "The domain for the Talos cluster"
  type        = string
}

variable "talos_image" {
  description = "The Talos image to use for the cluster"
  type = object({
    url          = string
    file_name    = string
    node_name    = string
    datastore_id = string
    overwrite    = bool
    content_type = optional(string, "iso")
  })
}

variable "node_data" {
  description = "A map of node data"
  type = object({
    controlplanes = map(object({
      hostname       = string
      pve_node       = string
      pve_id         = number
      memory         = number
      cores          = number
      disk_size      = number
      install_disk   = optional(string, "/dev/vda")
      start_on_boot  = optional(bool, true)
      network_bridge = optional(string, "vmbr0")
      datastore_id   = optional(string, "local-lvm")
    }))
    workers = map(object({
      hostname       = string
      pve_node       = string
      pve_id         = number
      memory         = number
      cores          = number
      disk_size      = number
      install_disk   = optional(string, "/dev/vda")
      start_on_boot  = optional(bool, true)
      network_bridge = optional(string, "vmbr0")
      datastore_id   = optional(string, "local-lvm")
    }))
  })
  default = {
    controlplanes = {}
    workers       = {}
  }
}