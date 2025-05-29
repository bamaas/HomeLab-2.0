#!/usr/bin/env bash
#MISE description="Lint the repo"
set -e

# Use mise's native parallel execution
mise run lint:yaml -r ::: \
    lint:shell -r ::: \
    lint:terraform -r ::: \
    lint:helm -r ::: \
    lint:helm-template -r ::: \
    lint:spelling -r ::: \
    lint:markdown -r

echo "All linting tasks completed!"