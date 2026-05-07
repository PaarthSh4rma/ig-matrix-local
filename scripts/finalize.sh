#!/bin/bash

set -e

echo "🔗 Finalizing bridge setup..."

# Generate registration
echo "⚙️ Generating bridge registration..."
docker compose run --rm mautrix-meta

# Copy registration to Synapse
echo "📄 Linking registration to Synapse..."
cp data/mautrix-meta/registration.yaml data/synapse/mautrix-meta-registration.yaml

# Ensure Synapse references it
if ! grep -q "mautrix-meta-registration.yaml" data/synapse/homeserver.yaml; then
  echo "🧩 Adding appservice config to Synapse..."
  echo "" >> data/synapse/homeserver.yaml
  echo "app_service_config_files:" >> data/synapse/homeserver.yaml
  echo "  - /data/mautrix-meta-registration.yaml" >> data/synapse/homeserver.yaml
fi

# Restart everything cleanly
echo "🔄 Restarting services..."
docker compose down
docker compose up -d

echo ""
echo "✅ Bridge setup complete!"
echo ""
echo "👉 Open Element:"
echo "http://localhost:8008 (homeserver)"
echo ""
echo "👉 Message:"
echo "@metabot:localhost"
echo ""
echo "👉 Then run:"
echo "login instagram"