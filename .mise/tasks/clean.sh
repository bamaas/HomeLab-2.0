#!/usr/bin/env bash
#MISE description="Cleanup tmp files"
set -e

echo "Cleaning up..."

# Remove all .tgz files in the apps directory
find "${ROOT_DIR}/apps" -path "*/*/*/Chart.lock" -type f -delete
find "${ROOT_DIR}/apps" -path "*/*/*/charts" -type d -exec rm -rf {} +

