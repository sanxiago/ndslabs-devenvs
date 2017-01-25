#!/bin/bash
set -e

if [ "$1" = "docker" ]; then

   $(which dind) docker daemon \
        --host=unix:///var/run/docker.sock \
        --host=tcp://0.0.0.0:2375 \
        --bip=10.1.0.1/16 \
        --registry-mirror=http://docker-cache.default:5001 \
        --mtu=1404 \
        --storage-driver=overlay  > dind.log 2>&1 &


    nodejs /cloud9/server.js -p 80 -w /workspace
else
   exec "$@"
fi
