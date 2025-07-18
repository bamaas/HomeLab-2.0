# Bootstrap

This directory contains the initial bootstrap configuration and manifests for setting up the Kubernetes cluster.

## 📂 Folder Structure

The `bootstrap` directory is organized as follows:

* `bootstrap.yaml`: The primary manifests that that initializes the core ApplicationSet for automated application discovery.

* `base`: Contains the foundational configuration manifests shared across all environments.
  * `resources/`: Contains cluster-wide Kubernetes resources required during the initial cluster setup
  (e.g., namespaces, RBAC, CRDs).
  * `misc/`: Holds miscellaneous configuration files and manifests used during the bootstrap process.
  * `projects/`: Defines ArgoCD project resources to logically group and manage applications within the cluster.

* `<env>/`: Environment-specific overlays that build upon the `base` configuration,
allowing customization for each deployment environment (e.g., `dev/`, `prd/`).
  * `resources/`: Overlays the `base/resources/` with environment-specific cluster-wide Kubernetes resources.
  * `misc/`: This directory overlays the `base/misc/` directory,
  allowing you to customize or extend bootstrap settings for each environment
  (e.g., adding environment-specific secrets, config maps, or initialization scripts).
  * `projects/`: This directory overlays the `base/projects/` directory,
  allowing you to customize or extend project definitions for each environment.

## 🛠️ Usage

The bootstrapping process is automated through the main project's Mise configuration:

```bash
mise run bootstrap <env>
```
