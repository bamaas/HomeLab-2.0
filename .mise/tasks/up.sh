#!/usr/bin/env bash
#MISE description="Setup the cluster from A to Z."
#MISE alias="setup"
set -e

# Arguments
ENV=$1

# Check if environment variable is provided
if [ -z "$1" ]; then
  echo "Error: environment not specified"
  echo "Usage: mise run up <environment>"
  echo "Example: mise run up dev"
  exit 1
fi

mise run provision "${ENV}"
mise run bootstrap
