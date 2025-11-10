#!/bin/bash
set +e  # Don't exit on errors

echo "Installing npm dependencies (ignoring native build scripts and optional deps)..."
npm install --ignore-scripts --no-optional 2>&1 | tee /tmp/npm-install.log
NPM_EXIT_CODE=${PIPESTATUS[0]}

# Check if critical dependencies were installed
if [ ! -d "node_modules/gulp" ] || [ ! -d "node_modules/typescript" ]; then
    echo "Critical dependencies missing, retrying without --no-optional..."
    npm install --ignore-scripts 2>&1 | grep -v "gyp ERR" | grep -v "native-keymap" || true
fi

echo "Running postinstall scripts..."
node build/npm/postinstall.js 2>&1 | grep -v "gyp ERR" | grep -v "native-keymap" || true

set -e  # Exit on errors from now on

echo "Building React components..."
npm run buildreact

echo "Compiling web version..."
npm run compile-web

echo "Build complete!"

