# .devcontainer

This directory contains the development container configuration, providing a consistent and isolated development environment.

The devcontainer image uses [Mise](https://mise.jdx.dev/) as a unified manager for tools as defined in the [Mise.toml](../mise.toml) file.

Upon entering the development container [mise run init](../.mise/init.sh) is invoked to automatically configure the [Git hooks](../.githooks).
