#!/bin/bash

cd ~/apps/gaspar

# set environment variables
source ~/apps/gaspar/setenv.sh

# login to ECR
aws ecr get-login-password | docker login --username AWS --password-stdin ${GASPAR_AWS_ACCOUNT_ID}.dkr.ecr.${GASPAR_AWS_REGION}.amazonaws.com

# run gaspar
docker-compose -f docker-compose.prod.yml stop
docker-compose -f docker-compose.prod.yml --env-file ~/apps/gaspar/.env up -d --build --force-recreate --pull "always"