#!/bin/bash

set -e

DEPLOY_SERVERS=$DEPLOY_SERVERS

echo "deploying to Digital Ocean production"

ssh root@$DEPLOY_SERVERS 'bash' < ./updateAndRestart.sh
