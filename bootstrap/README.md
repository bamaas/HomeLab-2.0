# Bootstrap

This directory contains the initial bootstrap configuration and manifests for setting up the Kubernetes cluster.

## Structure

* `bootstrap.yaml`: Main bootstrap configuration that initializes the core ApplicationSet for automated application discovery.
* `argocd/`: ArgoCD core installation and configuration
* `apps/`: Contains ApplicationSet definitions for automated application discovery and deployment
* `cluster-resources/`: Essential cluster-wide resources
* `misc/`: Miscellaneous bootstrap configurations
