# Base

This directory contains the foundational configuration manifests that are shared across all environments during the bootstrap process.

### Structure

- `resources/`: Contains cluster-wide Kubernetes resources required for initial cluster setup (e.g., RBAC, CRDs).
- `misc/`: Holds miscellaneous configuration files and manifests used during the bootstrap process.
- `projects/`: Defines ArgoCD project resources to logically group and manage applications within the cluster.

These base configurations are intended to be extended or overlaid by environment specific configurations in the corresponding environment directories (e.g., `../dev/`, `../prd/`).
