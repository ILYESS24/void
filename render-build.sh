#!/bin/bash
set -e

echo "Installing npm dependencies (ignoring native build scripts)..."
npm install --ignore-scripts

echo "Running postinstall scripts (excluding native builds)..."
node build/npm/postinstall.js || true

echo "Building React components..."
npm run buildreact

echo "Compiling web version..."
npm run compile-web

echo "Build complete!"

