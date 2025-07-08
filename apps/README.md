# Apps

This directory defines applications deployed to the cluster through GitOps workflows using ArgoCD.

## Structure

Applications are organized in a hierarchical structure following the pattern `project/namespace/app`:

* **Project**: Logical grouping of related applications (e.g., `foundation`, `home-automation`)
* **Namespace**: Kubernetes namespace where the application will be deployed
* **App**: Individual application containing its Helm charts and configurations

Each application directory contains:

* `Chart.yaml` - Helm chart metadata and dependencies
* `values.yaml` - Common configuration values
* `values.enc.yaml` - Common secret encrypted values
<!-- * `<env>.values.yaml` - Environment specific configuration values
* `<env>.values.enc.yaml` - Environment specific encrypted values -->
* `templates/` - Kubernetes manifests and Helm templates

## Deployment

* Applications are automatically discovered and deployed through [ArgoCD ApplicationSets](../bootstrap/apps/appset-bootstrap.yaml)
* Namespaces are created automatically during deployment if they don't exist
* Each application can have environment-specific configurations through separate values files (To be implemented)
