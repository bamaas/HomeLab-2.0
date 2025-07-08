#!/usr/bin/env bash
set -e

# Arguments
ENV=$1

# Check if environment variable is provided
if [ -z "$1" ]; then
  echo "Error: environment not specified"
  echo "Usage: mise run _:load-env-vars <environment>"
  echo "Example: mise run _:load-env-vars dev"
  exit 1
fi

# Decrypt the environment file
mise run decrypt "${ENV}.enc.env"

# Load environment variables from the decrypted JSON file
dec_env_file="${ENV}.dec.env"
echo "Loading environment variables from ${dec_env_file}..."
set -a  # Enable automatic export of all variables
# shellcheck source=/dev/null
source "${dec_env_file}"
set +a

rm "${dec_env_file}"


