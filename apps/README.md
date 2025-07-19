# Apps

The `apps` folder contains all the Kubernetes applications deployed in the cluster.

## Folder structure

Applications are organized into a logical hierarchical structure based on environment, project, namespace, and application.

- **`<env>/`**: Environment-specific folders (e.g., `dev`, `prod`).
  - **`<project>/`**: Grouped by project or purpose.
    - **`<namespace>/`**: Kubernetes namespaces for logical separation.
      - **`<app>/`**: Individual application manifests.

## Adding an application to the cluster

To add a new application to the cluster, follow these steps:

1. **Navigate to the appropriate environment and project directory:**

   ```bash
   cd apps/<env>/<project>/<namespace>/
   ```

   - Replace `<env>` with your target environment (e.g., `dev`, `prod`).
   - Choose or create the relevant `<project>` and `<namespace>` folders.
   - If the project does not exist, ensure to add a manifest to `root/bootstrap/<env>/projects` directory

2. **Create a new folder for your application:**

   ```bash
   mkdir -p apps/<env>/<project>/<namespace>/<app>
   ```

   - Replace `<app>` with the name of your application.

3. **Add your Kubernetes manifests:**
   - Place your `kustomization.yaml` and any other required manifest files inside the new application folder.

4. **Add sensitive or secret information:**
   - If your application requires secrets or sensitive configuration, create a `.dec.yaml` file in the application folder.
   - Encrypt the decrypted `*.dec.yaml` file with `mise encrypt <filepath>`.
   - The `.enc.yaml` is the designated place for sensitive information
   and will be handled securely by [SOPS](https://github.com/getsops/sops) during the deployment process.

5. **(Optional) Customize configuration:**
   - Add overlays or environment-specific configuration as needed.

6. **Commit and push:**
   - The GitOps workflow (via ArgoCD ApplicationSets) will automatically detect and deploy the new application.

> **_NOTE:_**  
> Namespaces are created automatically during deployment if they do not already exist.

---

### Helm Support via Kustomize

This project uses the [HelmChartInflationGenerator](https://kubectl.docs.kubernetes.io/references/kustomize/helmchartinflationgenerator/)
from Kustomize to declaratively manage Helm charts within the application folders.  

> **Known limitation:**  
> The Kustomize `HelmChartInflationGenerator` currently does **not** support overriding fields
> such as `valuesFile` or `version` in overlays,
> nor does it support adding additional values files in overlays.
> This means that if you want to use a different values file or chart version in an environment specific overlay,
> you must repeat the entire `helm-chart.yaml` definition in your overlay's `kustomization.yaml`.  
> This approach is not DRY.  
>
> For more context and ongoing discussion, see [kustomize issue #4658](https://github.com/kubernetes-sigs/kustomize/issues/4658).
