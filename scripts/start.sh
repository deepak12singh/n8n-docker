#!/bin/bash
set -e

echo "📤 Loading .env..."
export $(grep -v '^#' .env | xargs)

echo "🚀 Starting n8n stack..."
docker compose up -d
