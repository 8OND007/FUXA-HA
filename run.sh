#!/bin/sh
set -e

BASE_PATH="$(node -p "require('/data/options.json').BASE_PATH")"

echo "FUXA BASE_PATH=${BASE_PATH}"

export BASE_PATH

exec /usr/local/bin/docker-entrypoint.sh node main.js
