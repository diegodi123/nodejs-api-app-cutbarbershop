#!/bin/bash

set -e

DEPLOY_SERVERS=$DEPLOY_SERVERS
ENVIRONMENT=$ENVIRONMENT
#./disableHostKeyChecking.sh

echo "deploying to Digital Ocean production"

ssh root@$DEPLOY_SERVERS 'bash' < ./stopReleaseDeployment.sh
