#!/bin/bash

# set environment variables
source ./scripts/setenv-local-prod.sh

bin/rails db:migrate RAILS_ENV=production