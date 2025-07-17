#!/usr/bin/env bash
#MISE description="Encrypt a file with sops"
set -e

# Script arguments
dec_file="$1"
quiet=${2:-"false"}

# Check if dec_file is provided
if [ -z "$1" ]; then
  echo "Error: file not specified"
  echo "Usage: mise run encrypt path/to/file.dec.yaml"
  exit 1
fi

# Check if the file exists
if [ ! -f "${dec_file}" ]; then
  echo "Error: file not found"
  exit 1
fi

# Validate quiet argument input
if [ "${quiet}" != "true" ] && [ "${quiet}" != "false" ]; then
    echo "Error: quiet must be either 'false' or 'true'. Got ${quiet}."
    exit 1
fi

# Create the output filename with proper quoting
enc_file="${dec_file//.dec/.enc}"

# Encrypt the file
sops --encrypt "${dec_file}" > "${enc_file}"

[ "${quiet}" = "false" ] && echo "Encrypted ${dec_file} to ${enc_file}"