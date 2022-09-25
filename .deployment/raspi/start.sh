#!/bin/bash

# set environment variables
source ~/apps/gaspar/scripts/setenv.sh

echo testing env vars...
echo $GASPAR_AWS_REGION

# login to ECR
aws ecr get-login-password | docker login --username AWS --password-stdin ${GASPAR_AWS_ACCOUNT_ID}.dkr.ecr.${GASPAR_AWS_REGION}.amazonaws.com

# run gaspar
docker-compose -f docker-compose.prod.yml up