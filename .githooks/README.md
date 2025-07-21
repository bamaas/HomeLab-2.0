# .githooks

This directory contains Git hooks that are automatically installed and managed by the project to ensure code quality and consistency across all commits.

## Installation

To manually set up the hooks, run:

```bash
mise run init
```

Usually this is done automatically after running `mise install` which installs all the required tools and afterwards trigger a `mise run init` command as specified by the [postinstall hook](../.mise/config.toml).
