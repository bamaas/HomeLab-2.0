#!/usr/bin/env bash
#MISE description="Check spelling with codespell"
set -e

echo "Checking spelling..."
codespell --config "${LINT_CONFIG_DIR}/codespell.ini" . 