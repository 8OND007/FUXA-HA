#!/bin/sh
set -e

BASE_PATH="$(node -p "require('/data/options.json').BASE_PATH")"

export BASE_PATH

echo "=================================="
echo "FUXA startup"
echo "BASE_PATH=${BASE_PATH}"
echo "=================================="

exec /usr/local/bin/docker-entrypoint.sh node main.js
