#!/bin/bash

set -e

echo "change dir for aplication"
cd nodejs-api-app-cutbarbershop-production/

echo "Clone the repository into production"
git pull origin master

echo "Local:"
pwd

echo "Stoping containers"
docker-compose -f docker-compose.production.yml down

echo "Build image"
sudo docker build -t diegodi123/cutbarbershop-dockerizado-production:latest .

echo "Prune images and Containers"
docker container prune --force
docker image prune --force

echo "Starting containers"
docker-compose -f docker-compose.production.yml up -d

echo 'Upgrade migrations'
docker-compose -f docker-compose.production.yml run nodejs yarn typeorm migration:run

echo 'Starting server'
docker-compose run nodejs yarn dev:server
