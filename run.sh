#!/bin/sh

set -e

export BASE_PATH="$(node -p "require('/data/options.json').BASE_PATH")"

echo "Starting FUXA"
echo "BASE_PATH=${BASE_PATH}"

exec npm start
