#!/bin/bash

set -e

echo "⚙️ Configuring mautrix-meta..."

read -p "Enter your Matrix username (without @): " USERNAME
read -p "Enter your Postgres password: " DB_PASSWORD

CONFIG="data/mautrix-meta/config.yaml"

if [ ! -f "$CONFIG" ]; then
  echo "❌ config.yaml not found. Run setup.sh first."
  exit 1
fi

# Replace permissions
sed -i '' "s|@yourname:localhost|@$USERNAME:localhost|g" "$CONFIG"

# Replace DB password
sed -i '' "s|YOUR_PASSWORD|$DB_PASSWORD|g" "$CONFIG"

# Ensure correct host settings
sed -i '' "s|hostname: 127.0.0.1|hostname: 0.0.0.0|g" "$CONFIG"

echo "✅ Config updated!"
echo ""
echo "Next:"
echo "1. Run: make bridge-generate"
echo "2. Copy registration file"
echo "3. Restart services"