#!/usr/bin/with-contenv bashio

export BASE_PATH="$(bashio::config 'BASE_PATH')"

echo "Starting FUXA with BASE_PATH=${BASE_PATH}"

exec npm start
