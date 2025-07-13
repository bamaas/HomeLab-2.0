#!/usr/bin/env bash
#MISE description="Cleanup Helm charts.lock and charts directory"
set -e

# Remove all .tgz files in the apps directory
echo "Cleaning up Helm charts..."
find "${APPS_DIR}" -path "*/*/*/Chart.lock" -type f -delete
find "${APPS_DIR}" -path "*/*/*/charts" -type d -exec rm -rf {} +
echo "Done."