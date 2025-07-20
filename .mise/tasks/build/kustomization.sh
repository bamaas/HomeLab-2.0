#!/usr/bin/env bash
#MISE description="Build manifests of a single component"

# TODO: REFACTOR(!): This has grown into a monstrous bash script, refactor into a Python script.
set -euo pipefail

render_manifests(){
    # Function arguments
    kustomize_dir_path="$1"
    validate_schema="$2"
    debug="$3"

    # Parse app name from path
    app=$(basename "${kustomize_dir_path}")

    # Parse namespace from path
    namespace=$(basename "$(dirname "${kustomize_dir_path}")")

    # Find all *.enc.yaml files in the base dir 
    # TODO: make this smarter by traversing down the path referenced in the kustomization.yaml files and not just simply going to th base dir
    enc_yaml_files_in_base_dir=""
    base_dir="${kustomize_dir_path}/../../../../base/${app}"
    if [ -d "$base_dir" ]; then
        enc_yaml_files_in_base_dir=$(find "$base_dir" -type f -name "*.enc.yaml")
    fi

    # Find all *.enc.yaml files in the current dir
    enc_yaml_files_in_current_dir=$(find "${kustomize_dir_path}" -type f -name "*.enc.yaml")

    # Use yq to extract all values containing '.enc.yaml' in helm-chart.yaml
    enc_yaml_files_in_helm_chart=""
    if [ -f "${kustomize_dir_path}/helm-chart.yaml" ]; then
        enc_yaml_files_in_helm_chart=$(yq eval '.. | select(tag == "!!str" and test(".*\.enc\.yaml$"))' "${kustomize_dir_path}/helm-chart.yaml" | while read -r f; do
            [ -z "$f" ] && continue
            echo "${kustomize_dir_path}/$f"
        done)
    fi

    # Combine both lists, filter out duplicates
    # Normalize all paths to absolute, then filter out duplicates that point to the same file
    enc_yaml_files=$( (echo "$enc_yaml_files_in_current_dir"; echo "$enc_yaml_files_in_helm_chart"; echo "$enc_yaml_files_in_base_dir") | while read -r f; do
        [ -z "$f" ] && continue
        readlink -f "$f" 2>/dev/null
    done | sort -u)

    # Now for every file in enc_yaml_files decrypt it, write to a tmp file and then overwrite the original
    for file in $enc_yaml_files; do
        tmpfile=$(mktemp)
        [ "${debug}" = "true" ] && echo "Decrypting ${file}"
        sops --decrypt --input-type yaml --output-type yaml "$file" > "$tmpfile"
        mv "$tmpfile" "$file"
    done

    # Add the namespace to main kustomization
    if [[ "${kustomize_dir_path}" == *"/apps/"* ]]; then
        yq eval ".namespace = \"${namespace}\"" -i "${kustomize_dir_path}/kustomization.yaml";
    fi

    # if helm-chart exists in the current dir, set the namespace in it as well
    if [ -f "${kustomize_dir_path}/helm-chart.yaml" ]; then
        yq eval ".namespace = \"${namespace}\"" -i "${kustomize_dir_path}/helm-chart.yaml";
    fi

    # If helm-chart.yaml exists in base dir, set the namespace in it as well
    if [ -f "${base_dir}/helm-chart.yaml" ]; then
        yq eval ".namespace = \"${namespace}\"" -i "${base_dir}/helm-chart.yaml";
    fi

    # Creating the command
    cmd="kustomize build --enable-helm --enable-alpha-plugins --enable-exec --load-restrictor=LoadRestrictionsNone ${kustomize_dir_path}"
    if [ "$validate_schema" = "true" ]; then
        cmd="${cmd} | kubeconform -ignore-missing-schemas -summary -strict -kubernetes-version 1.32.0"
    fi

    # Render the manifests
    if [ "$debug" = "true" ]; then
        echo "Rendering: ${kustomize_dir_path}"
        echo "------------------------"
    fi
    eval "${cmd}"
}

###################
# Main
###################

# Script arguments
kustomize_dir_path="$1"
validate_schema=${2:-"false"}
debug=${3:-"false"}


# Validate debug argument input
if [ "${debug}" != "true" ] && [ "${debug}" != "false" ]; then
    echo "Error: debug must be either 'false' or 'true'. Got ${debug}."
    exit 1
fi

# Validate validate_schema argument input
if [ "${validate_schema}" != "true" ] && [ "${validate_schema}" != "false" ]; then
    echo "Error: validate_schema must be either 'false' or 'true'. Got ${validate_schema}."
    exit 1
fi

# Validate path exists
if [ ! -d "${kustomize_dir_path}" ]; then
    echo "Error: provided path '${kustomize_dir_path}' does not exist."
    exit 1
fi

# Validate kustomization.yaml file is present
if [ ! -f "${kustomize_dir_path}/kustomization.yaml" ]; then
    echo "Error: kustomization.yaml not found in '${kustomize_dir_path}'."
    exit 1
fi

# Create tmp directory containing a clone of bootstrap and apps dir
tmp_dir=$(mktemp -d)
mkdir -p "${tmp_dir}"
cp -a bootstrap apps "${tmp_dir}/"

absolute_kustomize_dir_path="$(readlink -f "${kustomize_dir_path}")"

# Remove the ROOT_DIR prefix from the absolute_kustomize_dir_path to get the relative path and prefix with ${tmp_dir}
tmp_kustomize_dir_path="${tmp_dir}/${absolute_kustomize_dir_path#"${ROOT_DIR}"/}"

# Render manifests
exit_code=0
render_manifests "${tmp_kustomize_dir_path}" "${validate_schema}" "${debug}" || exit_code=$?

# Cleanup tmp directories
[ "$debug" = "true" ] && (echo "------------------------"; echo "Cleaning up ${tmp_dir}")
rm -rf "${tmp_dir}"

# Exit
exit ${exit_code}