#!/bin/bash

# 👤 Define users
USER1=root
USER2=ubuntu
SHARED_GROUP=sharedgroup
TARGET_DIR=./data

echo "🔧 Creating shared group: $SHARED_GROUP (if not exists)"
sudo groupadd "$SHARED_GROUP" 2>/dev/null || true

echo "👥 Adding users to group: $USER1 and $USER2"
sudo usermod -aG "$SHARED_GROUP" "$USER1"
sudo usermod -aG "$SHARED_GROUP" "$USER2"

echo "📁 Changing group ownership of $TARGET_DIR to $SHARED_GROUP"
sudo chown -R "$USER1:$SHARED_GROUP" "$TARGET_DIR"

echo "🔐 Setting folder permissions:"
echo "• Directories → 2775 (rwxrwsr-x)"
echo "• Files → 664 (rw-rw-r--)"
sudo find "$TARGET_DIR" -type d -exec chmod 2775 {} \;
sudo find "$TARGET_DIR" -type f -exec chmod 664 {} \;

echo "✅ Group-based permission setup complete. Verifying:"
ls -ld "$TARGET_DIR"
ls -l "$TARGET_DIR"

echo "🔄 Setting full ownership of $TARGET_DIR to UID 1000"
sudo chown -R 1000:1000 "$TARGET_DIR"

echo "🎉 All done. Final check:"
ls -ld "$TARGET_DIR"
ls -l "$TARGET_DIR"

# 🔒 Final step: Secure acme.json for Traefik
echo "🔐 Securing acme.json file"
chmod 600 ./data/traefik/acme.json
sudo chmod 600 ./data/traefik/acme.json
