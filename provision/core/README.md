# Core

This directory contains Terraform configurations and scripts that handles the complete infrastructure setup,
from creating virtual machines on Proxmox to initializing a Kubernetes cluster with TalosOS.

## Folder structure

- `virtual_machines.tf` - Proxmox VM provisioning for TalosOS nodes
- `cluster.tf` - Kubernetes cluster initialization and configuration
- `*.tfvars` - Environment-specific variable files
- `outputs.tf` - Terraform output definitions
- `providers.tf` - Terraform provider configurations

## Usage

The provisioning process is automated through the following script:

```bash
mise run provision <env>
```

Or manually run the commands:

```bash
mise run terraform:plan <env>
mise run terraform:apply <env>
mise run kubeconfig <env>
mise run talosconfig <env>
```

Then ensure the cluster is up and running:

```bash
kubectl get nodes
```
