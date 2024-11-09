#!/bin/bash

# Configuration
BASE_DIR="./sftp"
CONFIG_DIR="$BASE_DIR/config"
DATA_DIR="$BASE_DIR/data"
PUID=1000
PGID=1000

# Create the necessary directories
mkdir -p "$CONFIG_DIR" "$DATA_DIR"

# Set permissions
chown -R $PUID:$PGID "$BASE_DIR"
chmod -R 755 "$BASE_DIR"

echo "Directories and permissions set. Initialization complete."
