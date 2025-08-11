#!/bin/bash
# Node.js Installation Script
# Maintained by: DevOps Engineer @sak_shetty
# Purpose: Install Node.js LTS (20.x) if not already installed

# Exit immediately if any command fails
set -e

echo "🔍 Checking if Node.js is already installed..."
if command -v node >/dev/null 2>&1; then
    echo "✅ Node.js is already installed. Skipping installation."
    echo "🔹 Node version: $(node -v)"
    echo "🔹 npm version: $(npm -v)"
else
    echo "🚀 Installing Node.js LTS (20.x)..."
    sudo apt update && sudo apt upgrade -y
    sudo apt install -y curl
    curl -fsSL https://deb.nodesource.com/setup_20.x | sudo -E bash -
    sudo apt install -y nodejs
    echo "✅ Node.js installation complete!"
    echo "🔹 Node version: $(node -v)"
    echo "🔹 npm version: $(npm -v)"
fi
