#!/usr/bin/env bash
set -euo pipefail

echo "Cleaning local Python and Docker artifacts..."

find . -type d -name "__pycache__" -prune -exec rm -rf {} +
find . -type d -name ".pytest_cache" -prune -exec rm -rf {} +
find . -type d -name ".ruff_cache" -prune -exec rm -rf {} +

docker image prune -f || true

echo "Done."
