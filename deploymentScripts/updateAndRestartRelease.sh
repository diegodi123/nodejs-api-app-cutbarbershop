#!/bin/bash

set -e

echo "change dir for aplication"
cd nodejs-api-app-cutbarbershop-release/

echo "Clone the repository"
git pull origin develop

echo "Local:"
pwd

echo "Stoping containers"
docker-compose -f docker-compose.release.yml down

echo "Build image"
sudo docker build -t diegodi123/cutbarbershop-dockerizado-release:latest .

echo "Prune images and Containers"
docker container prune --force
docker image prune --force

echo "Starting containers"
docker-compose -f docker-compose.release.yml up -d

echo 'Upgrade migrations'
docker-compose -f docker-compose.release.yml run nodejs yarn typeorm migration:run

echo 'Starting server'
docker-compose run nodejs yarn dev:server
