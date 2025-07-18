#!/usr/bin/env bash
#MISE description="Initialize the repo"
set -e

echo "Initializing repository..."

# Set githooks
echo "Setting githooks"
git config --local core.hooksPath .githooks/

# Get kubeconfig
state_exists=$(terraform -chdir="${TERRAFORM_DIR}" state list >/dev/null 2>&1; echo $?)
if [ "${state_exists}" -eq 0 ]; then
    test -f "${KUBECONFIG}" || mise run kubeconfig
fi

# Get talosconfig
if [ "${state_exists}" -eq 0 ]; then
    test -f "${TALOSCONFIG}" || mise run talosconfig
fi

echo -e "\e[32mRepository initialized.\e[0m"
