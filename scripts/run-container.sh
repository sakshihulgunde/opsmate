#!/bin/bash

set -e

echo "Starting OpsMate container..."

docker run -d \
  --name opsmate-app \
  -p 5000:5000 \
  opsmate:1.0

echo "Container started."

docker ps
