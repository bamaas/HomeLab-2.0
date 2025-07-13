terraform {
  required_providers {
    # https://registry.terraform.io/providers/bpg/proxmox/latest/docs
    proxmox = {
      source  = "bpg/proxmox"
      version = "0.74.0"
    }
    talos = {
      source  = "siderolabs/talos"
      version = "0.7.1"
    }
  }
}

provider "proxmox" {} # Passed via environment variables
provider "talos" {}