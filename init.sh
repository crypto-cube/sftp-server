#!/bin/bash

# Configuration
UPLOADS_DIR="./uploads"

echo "=== SFTP Server Initialization ==="
echo ""

# Create uploads directory with write-only permissions
echo "Creating uploads directory..."
mkdir -p "$UPLOADS_DIR"

# Set permissions to 733 (write-execute only, no read)
# This allows uploads but prevents listing/downloading
chmod 733 "$UPLOADS_DIR"

echo ""
echo "=== Initialization Complete ==="
echo ""
echo "Directory structure:"
echo "  ✓ Uploads directory: $UPLOADS_DIR (write-only permissions)"
echo ""
echo "Next steps:"
echo "  1. Build and start: docker compose up -d --build"
echo "  2. Connect via SFTP: sftp -P 2222 backup@localhost"
echo "  3. Password: yourpassword"
echo ""
echo "Security features:"
echo "  ✓ Chrooted to /home/backup/chroot"
echo "  ✓ Upload-only access (/uploads directory)"
echo "  ✓ No shell access (SFTP only)"
echo "  ✓ Directory permissions (733) prevent file listing/downloading"
