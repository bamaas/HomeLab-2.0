#!/usr/bin/env bash
#MISE description="Provision Talos cluster"
set -e

# Arguments
ENV=$1

# Check if environment variable is provided
if [ -z "$ENV" ]; then
  echo "Error: environment not specified"
  echo "Usage: mise run terraform:apply <environment>"
  echo "Example: mise run terraform:apply dev"
  exit 1
fi

mise run terraform:plan "${ENV}"
mise run terraform:apply "${ENV}"
mise run kubeconfig "${ENV}"
mise run talosconfig "${ENV}"