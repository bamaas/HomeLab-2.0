#!/usr/bin/env bash
#MISE description="Provision Talos cluster"
set -e

# Arguments
env=$1

# Check if environment variable is provided
if [ -z "${env}" ]; then
  echo "Error: environment not specified"
  echo "Usage: mise run terraform:apply <environment>"
  echo "Example: mise run terraform:apply dev"
  exit 1
fi

mise run terraform:plan "${env}"
mise run terraform:apply "${env}"
mise run kubeconfig "${env}"
mise run talosconfig "${env}"

echo -e "\e[32mProvision process completed.\e[0m"