#!/bin/bash

set -e

echo "Updating Ubuntu packages..."
sudo apt update

echo "Installing Docker..."
sudo apt install -y docker.io

echo "Starting Docker daemon..."
sudo systemctl start docker

echo "Enabling Docker at boot..."
sudo systemctl enable docker

echo "Checking Docker version..."
docker --version

echo "Checking Docker daemon..."
sudo systemctl status docker --no-pager
