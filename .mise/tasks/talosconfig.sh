#!/usr/bin/env bash
#MISE description="Get the talosconfig file"
set -e

# Arguments
env=$1

# Check if environment variable is provided
if [ -z "$1" ]; then
  echo "Error: environment not specified"
  echo "Usage: mise run talosconfig <environment>"
  echo "Example: mise run talosconfig dev"
  exit 1
fi

# Init
mise run terraform:init "${env}"

# Load environment variables
. "${ROOT_DIR}/.mise/tasks/.private/load-env-vars.sh" "${env}"

# Get talosconfig file from Terraform output
echo "Getting talosconfig file"
terraform \
    -chdir="${TERRAFORM_DIR}" \
        output \
            -raw talosconfig > .config/talosconfig

# Set correct permissions for the talosconfig file
chmod 600 .config/talosconfig