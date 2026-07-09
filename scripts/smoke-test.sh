#!/usr/bin/env bash
set -euo pipefail

API_ENDPOINT="${1:-}"

if [[ -z "${API_ENDPOINT}" ]]; then
  echo "Usage: ./scripts/smoke-test.sh https://api-id.execute-api.eu-central-1.amazonaws.com"
  exit 1
fi

echo "Testing ${API_ENDPOINT}/health"
curl --fail --show-error --silent "${API_ENDPOINT}/health"
echo
