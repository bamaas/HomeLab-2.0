#!/usr/bin/env bash
#MISE description="Setup the cluster from A to Z."
set -e

# Arguments
ENV=$1

# Check if environment variable is provided
if [ -z "$1" ]; then
  echo "Error: environment not specified"
  echo "Usage: mise run terraform:apply <environment>"
  echo "Example: mise run terraform:apply dev"
  exit 1
fi

# Verify that the environment file exists
if [ ! -f "${ENV}.tfvars" ]; then
  echo "Error: Environment file '${ENV}.tfvars' not found"
  exit 1
fi

mise run provision "${ENV}"
mise run bootstrap
