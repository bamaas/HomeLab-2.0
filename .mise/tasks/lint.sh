#!/usr/bin/env bash
#MISE description="Lint the repo"
set -e

# Use mise's native parallel execution
mise run lint:yaml -r ::: \
    lint:shell -r ::: \
    lint:terraform -r ::: \
    lint:manifests true -r ::: \
    lint:spelling -r ::: \
    lint:markdown -r

printf "\e[32mAll linting tasks completed!\e[0m\n"