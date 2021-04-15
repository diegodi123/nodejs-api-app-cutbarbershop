#!/bin/bash

set -e

echo "change dir for aplication"
cd nodejs-api-app-cutbarbershop/

ENVIRONMENT=$ENVIRONMENT

echo "Clone the repository"
git pull origin $ENVIRONMENT

echo "Local:"
pwd

echo "Stoping containers"
docker-compose down

echo "Build image"
sudo docker build -t diegodi123/cutbarbershop-dockerizado:latest .

echo "Prune images and Containers"
docker container prune --force
docker image prune --force

echo "Starting containers"
docker-compose up -d

echo 'Upgrade migrations'
docker-compose run nodejs yarn typeorm migration:run

echo 'Starting server'
docker-compose run nodejs yarn dev:server