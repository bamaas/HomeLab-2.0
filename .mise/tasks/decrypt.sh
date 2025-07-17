#!/usr/bin/env bash
#MISE description="Decrypt a file with sops"
set -e

# Script arguments
enc_file="$1"
quiet=${2:-"false"}

# Check if ENC_FILE is provided
if [ -z "$1" ]; then
  echo "Error: file not specified"
  echo "Usage: mise run encrypt path/to/file.dec.yaml"
  exit 1
fi

# Check if the file exists
if [ ! -f "${enc_file}" ]; then
  echo "Error: file not found"
  exit 1
fi

# Validate quiet argument input
if [ "${quiet}" != "true" ] && [ "${quiet}" != "false" ]; then
    echo "Error: quiet must be either 'false' or 'true'. Got ${quiet}."
    exit 1
fi

# Create the output filename with proper quoting
dec_file="${enc_file//.enc/.dec}"

# Decrypt the file
sops --decrypt "${enc_file}" > "${dec_file}"

[ "${quiet}" = "false" ] && echo "Decrypted ${enc_file} to ${dec_file}"