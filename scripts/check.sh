#!/bin/bash

echo "🔎 ig-matrix-local health check"
echo ""

echo "Docker:"
docker info >/dev/null 2>&1 && echo "✅ Docker is running" || echo "❌ Docker is not running"

echo ""
echo "Containers:"
docker compose ps

echo ""
echo "Synapse:"
curl -s http://localhost:8008/_matrix/client/versions >/dev/null \
  && echo "✅ Synapse reachable at http://localhost:8008" \
  || echo "❌ Synapse not reachable"

echo ""
echo "Bridge config:"
[ -f data/mautrix-meta/config.yaml ] \
  && echo "✅ Bridge config exists" \
  || echo "❌ Missing data/mautrix-meta/config.yaml"

echo ""
echo "Bridge registration:"
[ -f data/mautrix-meta/registration.yaml ] \
  && echo "✅ Bridge registration exists" \
  || echo "❌ Missing data/mautrix-meta/registration.yaml"

echo ""
echo "Synapse appservice registration:"
grep -q "mautrix-meta-registration.yaml" data/synapse/homeserver.yaml 2>/dev/null \
  && echo "✅ Synapse references bridge registration" \
  || echo "❌ Synapse does not reference bridge registration"