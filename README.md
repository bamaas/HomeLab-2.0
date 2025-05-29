# Homelab

My personal homelab playground, stored as code and automated.

## Pre-requisites

* Docker

## Get up and running

1. Setup devcontainer

2. To provision and configure full cluster simply run:

```bash
mise run setup <env>
```

## Project structure

This repository follows a GitOps approach using ArgoCD for continuous deployment.
The structure is organized as follows:

* `.lint/`: Contains linting configurations

* `.mise/`: Contains [Mise](https://mise.jdx.dev/) configurations

* `apps/`: Contains all applications deployed to the cluster
  * Organized in `project/namespace/app` structure
  * Each app contains its Helm charts and configurations
  * Namespaces are created automatically during deployment

* `bootstrap/`: Contains initial cluster setup and ArgoCD configuration
  * `argocd/`: ArgoCD core installation and configuration
  * `apps/`: Contains ApplicationSet definitions for automated application discovery and deployment
  * `cluster-resources/`: Essential cluster-wide resources
  * `misc/`: Miscellaneous bootstrap configurations

* `projects/`: Contains ArgoCD project definitions

* `provision/`: Contains Terraform infrastructure provisioning scripts and configurations

The repository uses ApplicationSets for automated deployment,
with configurations defined in `bootstrap/bootstrap.yaml`.
This setup enables automatic discovery and deployment of applications.

## To do

* Move ArgoCD to apps directory

* Implement option to provide secret values to Cilium install during bootstrapping

* Fix shellcheck issues
