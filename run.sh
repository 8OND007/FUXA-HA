#!/bin/sh
set -e

echo "=============================="
echo "CUSTOM FUXA RUN.SH IS RUNNING"
echo "=============================="

cat /data/options.json

BASE_PATH="$(node -p "require('/data/options.json').BASE_PATH")"

echo "BASE_PATH=${BASE_PATH}"

export BASE_PATH

exec /usr/local/bin/docker-entrypoint.sh node main.js
