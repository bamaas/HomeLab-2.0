#!/usr/bin/env bash
#MISE description="Lint shell scripts"
set -e

echo "Linting shell scripts..."
# shellcheck disable=SC2046
shellcheck $(find . -name "*.sh" ! -path "./.ignore/*") 