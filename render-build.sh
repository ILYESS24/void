#!/bin/bash
set -e

echo "Installing npm dependencies (ignoring native build scripts)..."
npm install --ignore-scripts 2>&1 | grep -v "gyp ERR" || true

echo "Running postinstall scripts (excluding native builds)..."
SKIP_NATIVE_BUILDS=1 node build/npm/postinstall.js 2>&1 | grep -v "gyp ERR" || true

echo "Building React components..."
npm run buildreact

echo "Compiling web version..."
npm run compile-web

echo "Build complete!"

