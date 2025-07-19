# Base

This directory contains the base Kubernetes manifests and configuration files that serve as the foundation for environments. 
The resources here are environment-agnostic and are intended to be reused or extended by environment specific overlays.

Typical contents may include:
- Common Helm charts
- Base secrets

> **Note:**  
> *Namespace* manifests are not required here, as namespaces are automatically created during deployment.  
> *Project* manifest should be stored in [bootstrap/base/projects](../../bootstrap/base/projects/)