#!/usr/bin/env bash
#MISE description="Lint Markdown files"
set -e

echo "Linting Markdown files..."
markdownlint \
	-c "${LINT_CONFIG_DIR}/markdownlint.yaml" \
	-p "${LINT_CONFIG_DIR}/.markdownlintignore" \
	./**/*.md 