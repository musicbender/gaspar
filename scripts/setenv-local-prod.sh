#!/bin/bash

# Show env vars
grep -v '^#' .env.local.prod

# Export env vars
export $(grep -v '^#' .env.local.prod | xargs)