#!/usr/bin/env bash
#MISE description="Lint the repo"
set -e

# Run all linting tasks
mise run lint:yaml
mise run lint:shell
mise run lint:terraform
mise run lint:helm
mise run lint:helm-template
mise run lint:codespell
mise run lint:markdown