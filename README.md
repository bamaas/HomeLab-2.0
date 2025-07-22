# 🏠 HomeLab-2.0 💻

My personal homelab playground, stored as code.

> The goal is to seamlessly bootstrap a Kubernetes cluster with all the bells and whistles  
> — from infrastructure to apps —  
> in one smooth, reproducible flow.  
> Aiming to keep things as lightweight and simple as possible, while still providing flexibility.

## ✨ Features

- **🚀 One-command cluster provisioning**  
  Provision and configure a full Kubernetes cluster with a single command: `mise run up <env>`  

- **🔍 Automatic application discovery**  
  No need to manually define ArgoCD application manifests — applications are automatically detected and deployed.

- **🧰 One entrypoint to rule them all**  
  No more memorizing complex commands. All essential workflows are defined as Mise tasks—your single, consistent entrypoint for development.  
  Run `mise tasks` to discover everything you need.

- **✅ Catch issues before they catch you**  
  Every commit runs automatic pre-commit checks that generate and lint your Kubernetes manifests against the API spec.  
  So you catch mistakes early, not in production.

- **🛠️ Isolated development setup, zero headaches**  
  Work in an isolated, reproducible environment powered by Mise and Dev Containers  
  so you always have the right tools, versions, and setup from day one.

- **🌍 Manage multiple environments effortlessly**  
  Build on a shared base with environment-specific overlays for clear separation and reproducibility.

- **🔐 Secret management made easy**  
Secure your secrets with SOPS: encrypted, version-controlled, and stored right alongside your config.  
No external vaults, no guesswork.

## 🏛️ Foundation stack

This section describes the essential infrastructure components that form the backbone of the homelab environment.

- **Infrastructure**  
  [Terraform](https://developer.hashicorp.com/terraform),
  [Proxmox VE](https://www.proxmox.com/en/proxmox-ve),
  [TalosOS](https://www.talos.dev/)

- **GitOps**  
  [ArgoCD](https://argo-cd.readthedocs.io/)
  [Kustomize](https://kustomize.io/)

- **Networking**  
  [Cilium CNI](https://cilium.io/),
  [MetalLB](https://metallb.universe.tf/),
  [Nginx Ingress Controller](https://kubernetes.github.io/ingress-nginx/)

- **Storage**  
  [Synology iSCSI & NFS](https://github.com/zebernst/synology-csi-talos)

- **Monitoring**  
  [VictoriaLogs](https://docs.victoriametrics.com/victorialogs/),
  [Vector](https://vector.dev/),
  [VictoriaMetrics](https://victoriametrics.com/) *Planned*

- **Security**  
  [Cert-Manager](https://cert-manager.io/),
  [SOPS](https://github.com/getsops/sops),
  [Azure Key Vault](https://azure.microsoft.com/nl-nl/products/key-vault),
  [Trivy](https://github.com/aquasecurity/trivy-operator) *Planned*

- **Authentication**  
  [Dex](https://dexidp.io/) *Planned*

- **Development**  
  [Mise](https://mise.jdx.dev/),
  [Docker](https://www.docker.com/)

## 🚀 Get up and running

How to deploy the entire cluster from the ground up.

1. **Setup devcontainer.**

    This will [setup](.devcontainer/Dockerfile) all the required tools needed for project development.

2. **To provision and configure a full-blown cluster simply run:**

    ```bash
    mise run up <env>
    ```

    This command will:

    1. Use Terraform to [provision](./provision/core/virtual_machines.tf) TalosOS machines on the Proxmox host
    and [initialize](./provision/core/cluster.tf) the Kubernetes cluster.

    1. [Deploy ArgoCD](.mise/tasks/bootstrap.sh) using the bootstrap configuration to enable GitOps workflows.

    1. Automatically discover and deploy all applications defined in the `apps/` directory through [ArgoCD ApplicationSets](./bootstrap/bootstrap.yaml).

3. **Good to go 🎉**

    The Kubeconfig and Talosconfig files are automaticalled fetched and stored in [.config](.config) directory and your shell is configured [automatically](.mise/config.toml).

    You can now interact with the cluster: `kubectl get pods -A`

## 📂 Project structure

This repository follows a GitOps approach using ArgoCD for continuous deployment.
The structure is organized as follows:

* `.lint/`: Linting configurations

* `.mise/`: Mise configurations
  * `tasks`: Reusable scripts for cluster management, provisioning, and automation.

* `apps/`: Contains all applications deployed to the cluster
  * Organized in `<env>/<project>/<namespace>/<app>` structure
  * Each app contains its kustomization.yaml and configurations
  * Namespaces are created automatically during deployment

* `bootstrap/`: Contains initial cluster setup and ArgoCD configuration
  * `projects/`: Contains ArgoCD project definitions
  * `resources/`: Essential cluster-wide resources
  * `misc/`: Miscellaneous bootstrap configurations

* `provision/`: Contains Terraform infrastructure provisioning scripts and configurations
  * `core/`: Core Terraform modules and scripts for cluster provisioning
  * `<env>/`: Environment-specific Terraform variable files (e.g., `dev/`, `prd/`)


## 📝 To do

This section outlines a list of planned improvements and upcoming features, presented in no particular order.

- [ ] Investigate [Cilium load balancer IPAM](https://docs.cilium.io/en/stable/network/lb-ipam/) as al alternative for Metallb.

- [ ] Investigate [Cillum Gateway API](https://cilium.io/use-cases/gateway-api/) as an alternative for Nginx ingress controller.

- [ ] Implement [Dex IdP](https://dexidp.io/).

- [ ] Implement [VictoriaMetrics](https://victoriametrics.com/).

- [ ] Implement a metric collector (to be determined).

- [ ] Create production environment.

- [ ] Refactor ArgoCD config management plugin script.

- [ ] Setup alerting rules and channels.

- [ ] Deploy [Trivy Operator](https://github.com/aquasecurity/trivy-operator).

- [ ] Checkout [Sidero Omni](https://github.com/siderolabs/omni).

- [ ] Deploy and configure [External DNS](https://kubernetes-sigs.github.io/external-dns/latest/) to be able to [manage PiHole](https://kubernetes-sigs.github.io/external-dns/v0.13.3/tutorials/pihole/#service-example).

- [ ] Implement [KRR](https://github.com/robusta-dev/krr)
