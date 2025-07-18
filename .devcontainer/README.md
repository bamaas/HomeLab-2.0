# .devcontainer

This directory contains the development container configuration, providing a consistent and isolated development environment.

The devcontainer image uses [Mise](https://mise.jdx.dev/) as a unified manager for tools as defined in the [Mise.toml](../mise.toml) file.

Upon entering the development container [mise run init](../.mise/init.sh) is invoked to automatically configure the [Git hooks](../.githooks).

## 🛠️ Usage

1. **Install Prerequisites**:  
   - Visual Studio Code
   - Docker
   - Dev Containers Extension

2. **Reopen in Container**:  
    Press `F1` (or `Cmd+Shift+P` on Mac) and select **Dev Containers: Reopen in Container**.
    VS Code will build and start the development container based on the [.devcontainer](./devcontainer.json) configuration.