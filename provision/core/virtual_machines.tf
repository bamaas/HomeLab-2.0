# Define common VM configuration as a local value
locals {
  common_vm_config = {
    description     = "Managed by Terraform"
    tags            = ["terraform"]
    cpu_type        = "x86-64-v2-AES"
    file_format     = "raw"
    interface       = "virtio0"
    os_type         = "l26" # Linux Kernel 2.6 - 5.X.
    agent_enabled   = false # TODO: can't get qemu-guest-agent running in the VM.
    stop_on_destroy = true  # # if agent is not enabled, the VM may not be able to shutdown properly, and may need to be forced off
  }
}

# First create control plane nodes
resource "proxmox_virtual_environment_vm" "control_planes" {
  for_each = var.node_data.controlplanes

  # Common attributes
  name        = each.value.hostname
  description = local.common_vm_config.description
  tags        = local.common_vm_config.tags
  node_name   = each.value.pve_node
  on_boot     = each.value.start_on_boot
  vm_id       = each.value.pve_id

  cpu {
    cores = each.value.cores
    type  = local.common_vm_config.cpu_type
  }

  memory {
    dedicated = each.value.memory
  }

  agent {
    enabled = local.common_vm_config.agent_enabled
  }

  stop_on_destroy = local.common_vm_config.stop_on_destroy

  network_device {
    bridge = each.value.network_bridge
  }

  disk {
    datastore_id = each.value.datastore_id
    file_id      = proxmox_virtual_environment_download_file.talos_image.id
    file_format  = local.common_vm_config.file_format
    interface    = local.common_vm_config.interface
    size         = each.value.disk_size
  }

  operating_system {
    type = local.common_vm_config.os_type
  }

  initialization {
    datastore_id = each.value.datastore_id
    ip_config {
      ipv4 {
        address = "${each.key}/24"
        gateway = var.default_gateway
      }
      ipv6 {
        address = "dhcp"
      }
    }
  }
}

# Then create worker nodes with a simple dependency
resource "proxmox_virtual_environment_vm" "workers" {
  for_each   = var.node_data.workers
  depends_on = [proxmox_virtual_environment_vm.control_planes]

  # Common attributes
  name        = each.value.hostname
  description = local.common_vm_config.description
  tags        = local.common_vm_config.tags
  node_name   = each.value.pve_node
  on_boot     = each.value.start_on_boot
  vm_id       = each.value.pve_id

  cpu {
    cores = each.value.cores
    type  = local.common_vm_config.cpu_type
  }

  memory {
    dedicated = each.value.memory
  }

  agent {
    enabled = local.common_vm_config.agent_enabled
  }

  stop_on_destroy = local.common_vm_config.stop_on_destroy

  network_device {
    bridge = each.value.network_bridge
  }

  disk {
    datastore_id = each.value.datastore_id
    file_id      = proxmox_virtual_environment_download_file.talos_image.id
    file_format  = local.common_vm_config.file_format
    interface    = local.common_vm_config.interface
    size         = each.value.disk_size
  }

  operating_system {
    type = local.common_vm_config.os_type
  }

  initialization {
    datastore_id = each.value.datastore_id
    ip_config {
      ipv4 {
        address = "${each.key}/24"
        gateway = var.default_gateway
      }
      ipv6 {
        address = "dhcp"
      }
    }
  }
}