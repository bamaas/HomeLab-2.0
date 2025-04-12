#!/usr/bin/env bash
#MISE description="Init the repo"
set -e
echo "Initializing repository..."

mise run decrypt .env.enc.json

# Reload environment variables from mise
eval "$(mise env)"
echo "Environment variables reloaded from mise"

echo "Initializing Terraform"
terraform -chdir="${TERRAFORM_DIR}" init

# Set githooks
echo "Setting githooks"
git config --local core.hooksPath .githooks/

echo "Repository initialized"
