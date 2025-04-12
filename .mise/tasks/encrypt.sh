#!/usr/bin/env bash
#MISE description="Encrypt a file with sops"
set -e

DEC_FILE=$1

# Check if DEC_FILE is provided
if [ -z "$1" ]; then
  echo "Error: file not specified"
  echo "Usage: mise run encrypt path/to/file.dec.yaml"
  exit 1
fi

# Check if the file exists
if [ ! -f "${DEC_FILE}" ]; then
  echo "Error: file not found"
  exit 1
fi

# Create the output filename with proper quoting
ENC_FILE="${DEC_FILE//.dec/.enc}"

# Encrypt the file
sops --encrypt "${DEC_FILE}" > "${ENC_FILE}"

echo "Encrypted ${DEC_FILE} to ${ENC_FILE}"