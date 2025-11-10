#!/bin/bash
set -e

echo "Installing system dependencies..."
apt-get update -qq && apt-get install -y -qq libxkbfile-dev libx11-dev libsecret-1-dev || true

echo "Installing npm dependencies..."
npm install || npm install --ignore-scripts

echo "Building React components..."
npm run buildreact

echo "Compiling web version..."
npm run compile-web

echo "Build complete!"

