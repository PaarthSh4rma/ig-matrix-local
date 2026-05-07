#!/bin/bash

set -e

echo "🚀 Setting up ig-matrix-local..."

# Step 1: env
if [ ! -f .env ]; then
  echo "📄 Creating .env file..."
  cp .env.example .env
  echo "⚠️  Please edit .env and set POSTGRES_PASSWORD"
  exit 1
fi

# Step 2: generate Synapse config if missing
if [ ! -f data/synapse/homeserver.yaml ]; then
  echo "⚙️ Generating Synapse config..."
  docker compose run --rm synapse generate
fi

# Step 3: start core services
echo "🐳 Starting Postgres + Synapse..."
docker compose up -d postgres synapse

sleep 5

# Step 4: generate bridge config if missing
if [ ! -f data/mautrix-meta/config.yaml ]; then
  echo "🔗 Generating bridge config..."
  docker compose run --rm mautrix-meta
fi

# Step 5: create bridge DB
echo "🗄️ Ensuring bridge database exists..."
docker compose exec postgres psql -U synapse -d synapse -c "CREATE DATABASE mautrix_meta;" || true

echo ""
echo "✅ Base setup complete!"
echo ""
echo "Next steps:"
echo "1. Edit data/mautrix-meta/config.yaml"
echo "2. Run: make bridge-generate"
echo "3. Copy registration file"
echo "4. Restart services"
echo "5. Login via @metabot:localhost"