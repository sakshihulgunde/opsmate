#!/bin/bash

set -e

echo "Building OpsMate Docker image..."

docker build -t opsmate:1.0 .

echo "Docker image created successfully."

docker images opsmate
