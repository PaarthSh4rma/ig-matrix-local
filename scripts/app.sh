#!/bin/bash

echo "🚀 Launching IG Matrix Local..."

# Start services
docker compose up -d

# Wait for Element to be ready
echo "⏳ Waiting for app to be ready..."
sleep 5

# Open app
open http://localhost:3000

echo "✅ App launched!"