#!/bin/bash

set -e

ENVIRONMENT=$ENVIRONMENT
CI_ENVIRONMENT_NAME=$CI_ENVIRONMENT_NAME

echo "Clone the repository into $CI_ENVIRONMENT_NAME"
git pull origin $ENVIRONMENT

echo "change dir for aplication"
cd nodejs-api-app-cutbarbershop-$CI_ENVIRONMENT_NAME/

echo "Local:"
pwd

echo "Stoping containers"
docker-compose -f docker-compose.$CI_ENVIRONMENT_NAME.yml down

echo "Build image"
sudo docker build -t diegodi123/cutbarbershop-dockerizado-$CI_ENVIRONMENT_NAME:latest .

echo "Prune images and Containers"
docker container prune --force
docker image prune --force

echo "Starting containers"
docker-compose -f docker-compose.$CI_ENVIRONMENT_NAME.yml up -d

echo 'Upgrade migrations'
docker-compose run nodejs yarn typeorm migration:run

echo 'Starting server'
docker-compose run nodejs yarn dev:server
