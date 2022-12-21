#!/bin/bash

kill -9 `cat ./tmp/pids/server.pid`
rm ./tmp/pids/server.pid
echo "Gaspar ready!"
source "./scripts/banner.sh"
bundle exec rails server -b "0.0.0.0" -e development