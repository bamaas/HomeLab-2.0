#!/usr/bin/env bash
#MISE description="Build manifests for all the components and validate manifests are following the Kubernetes API schema."
set -e
validate_schema="true"
mise run build:kustomizations "${validate_schema}"