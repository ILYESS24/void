#!/bin/bash
set +e  # Don't exit on errors

echo "Installing npm dependencies (ignoring native build scripts)..."
npm install --ignore-scripts 2>&1 | grep -v "gyp ERR" | grep -v "native-keymap" || true

# Install rollup native dependencies manually if needed
if [ ! -d "node_modules/@rollup/rollup-linux-x64-gnu" ]; then
    echo "Installing rollup native dependencies..."
    npm install @rollup/rollup-linux-x64-gnu --save-optional --ignore-scripts 2>&1 | grep -v "gyp ERR" || true
fi

echo "Running postinstall scripts..."
node build/npm/postinstall.js 2>&1 | grep -v "gyp ERR" | grep -v "native-keymap" || true

set -e  # Exit on errors from now on

echo "Building React components..."
npm run buildreact

echo "Compiling web version (with increased memory limit)..."
NODE_OPTIONS="--max-old-space-size=4096" npm run compile-web

echo "Build complete!"

