#!/usr/bin/env bash
#MISE description="Build manifests of all the components in the repository"
set -e

# Script arguments
validate_schema=${1:-0}
debug=${3:-"false"}

# Validate debug argument input
if [ "${debug}" != "true" ] && [ "${debug}" != "false" ]; then
    echo "Error: debug must be either 'false' or 'true'. Got ${debug}."
    exit 1
fi

# Initialize the string variable
cmd=""

# Find all apps directoreis containing kustomization.yaml
# Use a process substitution to ensure the loop runs in the current shell, so 'cmd' is updated as expected.
while read -r kustomize_dir_path; do
    if [ -z "$cmd" ]; then
        cmd="mise run build:kustomization ${kustomize_dir_path} ${validate_schema} ${debug} -r"
    else
        cmd="$cmd ::: build:kustomization ${kustomize_dir_path} ${validate_schema} ${debug} -r"
    fi
done < <(
    find "${ROOT_DIR}/apps/" -name "kustomization.yaml" -not -path "${ROOT_DIR}/apps/base/*" -exec dirname {} \;
    find "${ROOT_DIR}/bootstrap/" -name "kustomization.yaml" -not -path "${ROOT_DIR}/bootstrap/base/*" -exec dirname {} \;
)

# Execute the variable as a command
eval "$cmd"