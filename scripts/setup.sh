#!/bin/bash
set -e

echo "🔧 Loading environment..."
export $(grep -v '^#' ../.env | xargs)

echo "📦 Installing dependencies..."
sudo apt update
sudo apt install -y \
  docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin \
  nginx certbot python3-certbot-nginx curl

echo "👥 Adding user to docker group..."
sudo usermod -aG docker $USER
newgrp docker

echo "📝 Setting up Nginx..."
envsubst '${DOMAIN} ${N8N_PORT}' < ../nginx/sites-available/n8n | sudo tee /etc/nginx/sites-available/n8n > /dev/null
sudo ln -sf /etc/nginx/sites-available/n8n /etc/nginx/sites-enabled/n8n
sudo nginx -t && sudo systemctl reload nginx

echo "🔐 Requesting SSL cert for $DOMAIN..."
sudo certbot --nginx -d "$DOMAIN" --non-interactive --agree-tos -m you@example.com

echo "🔁 Enabling cert auto-renewal..."
sudo systemctl enable --now certbot.timer

echo "✅ Setup complete."
