#!/usr/bin/env bash
#MISE description="Cleanup tmp files"
set -e

echo "Cleaning up..."

mise run clean:helm

printf "\e[32mAll cleanup tasks completed.\e[0m\n"