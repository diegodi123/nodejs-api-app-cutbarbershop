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
