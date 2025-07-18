# Config

This directory contains client configuration files for the homelab environment, specifically the `talosconfig` and `kubeconfig` files.

Normally these configuration files are automatically retrieved during environment setup using:

```bash
mise run up <env>
```

Alternatively, you can manually fetch them with the following commands:

```bash
mise run talosconfig
mise run kubeconfig
```
