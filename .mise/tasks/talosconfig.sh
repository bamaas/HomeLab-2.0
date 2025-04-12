#!/usr/bin/env bash
#MISE description="Get the talosconfig file"
set -e
echo "Getting talosconfig file"
terraform -chdir="${TERRAFORM_DIR}" output -raw talosconfig > .config/talosconfig
chmod 600 .config/talosconfig