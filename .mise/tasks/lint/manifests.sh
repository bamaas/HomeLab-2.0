#!/usr/bin/env bash
#MISE description="Lint manifests for all charts"
set -e

SCHEMA_VALIDATION=$1

mise run clean -r

# Initialize the string variable
cmd=""

# Find all directories containing Chart.yaml files
while IFS= read -r -d '' chart_dir; do
    # Get the directory path
    dir_path=$(dirname "$chart_dir")
    
    # Append to string variable with separator
    if [ -z "$cmd" ]; then
        cmd="mise run lint:manifest $dir_path $SCHEMA_VALIDATION -r"
    else
        cmd="$cmd ::: lint:manifest $dir_path $SCHEMA_VALIDATION -r"
    fi
done < <(find "${APPS_DIR}" -name "Chart.yaml" -not -path "*/\.ignore/*" -print0)

# Execute the variable as a command
eval "$cmd"