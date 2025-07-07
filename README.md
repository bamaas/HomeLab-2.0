# 🏠 Homelab

My personal homelab playground, stored as code and fully automated.

## 🚀 Get up and running

1. **Setup devcontainer.**

    This will [bootstrap](.devcontainer/Dockerfile) all the required tools needed for project development.
    The project uses [Mise](https://mise.jdx.dev/) as a unified manager for tools, environment variables, and scripts.

2. **To provision and configure full cluster simply run:**

    ```bash
    mise run up <env>
    ```

    This command will:

    1. Use Terraform to [provision](./provision/virtual_machines.tf) TalosOS machines on the Proxmox host
    and [initialize](./provision/cluster.tf) the Kubernetes cluster.

    1. [Deploy ArgoCD](.mise/tasks/bootstrap.sh) using the bootstrap configuration to enable GitOps workflows.

    1. Automatically discover and deploy all applications defined in the `apps/` directory through [ArgoCD ApplicationSets](./bootstrap/apps/appset-bootstrap.yaml).

3. **Good to go 🎉**

    The Kubeconfig and Talosconfig files are automaticalled fetched and stored in [.config](.config) directory and your shell is configured [automatically](mise.toml).

    You can now interact with the cluster: `kubectl get pods -A`
  

## 🔥 Foundation stack

This section describes the essential infrastructure components that form the backbone of the homelab environment.

* **Infrastructure**:
[Proxmox VE](https://www.proxmox.com/en/proxmox-ve),
[TalosOS](https://www.talos.dev/) -> [Kubernetes](https://kubernetes.io/)
* **GitOps**:
[ArgoCD](https://argo-cd.readthedocs.io/)
* **Networking**:
[Cilium CNI](https://cilium.io/),
[MetalLB](https://metallb.universe.tf/),
[Nginx Ingress Controller](https://kubernetes.github.io/ingress-nginx/)
* **Storage**:
[Synology iSCSI & NFS](https://github.com/zebernst/synology-csi-talos)
* **Monitoring**:
[VictoriaLogs](https://docs.victoriametrics.com/victorialogs/),
[Vector](https://vector.dev/),
[VictoriaMetrics](https://victoriametrics.com/) (Planned)
* **Security**:
[Cert-Manager](https://cert-manager.io/),
[SOPS](https://github.com/getsops/sops),
[Azure Key Vault](https://azure.microsoft.com/nl-nl/products/key-vault),
[Trivy](https://github.com/aquasecurity/trivy-operator) (Planned)
* **Authentication**:
[Dex](https://dexidp.io/) (Planned)
* **Development**:
[Terraform](https://developer.hashicorp.com/terraform),
[Helm](https://helm.sh/),
[Mise](https://mise.jdx.dev/),
[Docker](https://www.docker.com/)

## 📂 Project structure

This repository follows a GitOps approach using ArgoCD for continuous deployment.
The structure is organized as follows:

* `.lint/`: Contains linting configurations

* `.mise/`: Contains Mise configurations

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

The repository uses ArgoCD ApplicationSets for automated deployment,
with configurations defined in `bootstrap/apps.yaml`.
This setup enables automatic discovery and deployment of applications.

## 📝 To do

This section outlines a list of planned improvements and upcoming features, presented in no particular order.

* Move ArgoCD to apps directory

* Fix shellcheck issues

* Investigate [Cillium load balancer IPAM](https://docs.cilium.io/en/stable/network/lb-ipam/) as al alternative for Metallb.

* Investigate [Cillum Gateway API](https://cilium.io/use-cases/gateway-api/) as an alternative for Nginx ingress controller.

* Implement [Dex IdP](https://dexidp.io/).

* Implement [VictoriaMetrics](https://victoriametrics.com/).

* Implement a metric collector (to be determined).

* Setup alerting rules and channels.

* Deploy [Trivy Operator](https://github.com/aquasecurity/trivy-operator).

* Checkout [Sidero Omni](https://github.com/siderolabs/omni).

* Deploy and configure [External DNS](https://kubernetes-sigs.github.io/external-dns/latest/) to be able to [manage PiHole](https://kubernetes-sigs.github.io/external-dns/v0.13.3/tutorials/pihole/#service-example).
