#!/bin/bash

set -e

DEPLOY_SERVERS=$DEPLOY_SERVERS

#./disableHostKeyChecking.sh

echo "deploying to Digital Ocean production"

ssh root@$DEPLOY_SERVERS 'bash' < ./updateAndRestartDevelop.sh
