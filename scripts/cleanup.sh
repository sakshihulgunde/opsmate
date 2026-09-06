#!/bin/bash

echo "Stopping OpsMate container if running..."
docker stop opsmate-app 2>/dev/null || true

echo "Removing OpsMate container..."
docker rm opsmate-app 2>/dev/null || true

echo "Removing unused Docker resources..."
docker system prune -f

echo "Cleanup completed."
