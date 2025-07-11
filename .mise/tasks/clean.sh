#!/usr/bin/env bash
#MISE description="Cleanup tmp files"
set -e

echo "Cleaning up..."

mise run clean:helm

echo "All cleanup tasks completed!"