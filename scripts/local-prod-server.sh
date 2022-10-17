#!/bin/bash

kill -9 `cat tmp/pids/server.pid`
echo "Gaspar local prod ready!"
source "./scripts/banner.sh"

# set environment variables
source ./scripts/setenv-local-prod.sh

bundle exec rails server -e production