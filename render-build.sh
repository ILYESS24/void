#!/bin/bash
set -e

echo "Installing dependencies (ignoring native build scripts for web deployment)..."
npm install --ignore-scripts

echo "Building React components..."
npm run buildreact

echo "Compiling web version..."
npm run compile-web

echo "Build complete!"

