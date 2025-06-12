#!/bin/bash
set -e

echo "🚀 Initializing Beepload - Ultimate Upload System"

# Create .env file if it doesn't exist
if [ ! -f .env ]; then
    echo "📄 Creating .env file from template..."
    cp .env.example .env
    echo "✅ Created .env file. Please update it with your configuration."
else
    echo "ℹ️  .env file already exists. Skipping creation."
fi

# Create required directories
echo "📁 Creating required directories..."
mkdir -p services/upload-service services/approval-service services/config-service services/notification-service
mkdir -p kratos/config kratos/templates frontend/src manager-frontend/src admin-frontend/src webdav-storage

echo "✅ Directory structure created."

# Set up WebDAV password
if [ -z "$WEBDAV_PASSWORD" ]; then
    read -sp "🔑 Enter WebDAV password (leave empty to generate random): " WEBDAV_PASSWORD
    echo
    
    if [ -z "$WEBDAV_PASSWORD" ]; then
        WEBDAV_PASSWORD=$(openssl rand -base64 16)
        echo "🔑 Generated random WebDAV password: $WEBDAV_PASSWORD"
    fi
    
    # Update .env with WebDAV password
    sed -i.bak "s/^WEBDAV_PASSWORD=.*/WEBDAV_PASSWORD=$WEBDAV_PASSWORD/" .env
    
    # Generate and update WebDAV password hash
    echo "🔑 Generating WebDAV password hash..."
    HASH=$(docker run --rm caddy:2-alpine caddy hash-password --plaintext "$WEBDAV_PASSWORD" | tr -d '\r')
    sed -i.bak "s/^WEBDAV_PASSWORD_HASH=.*/WEBDAV_PASSWORD_HASH=$HASH/" .env
    
    # Clean up backup file
    rm -f .env.bak
    
    echo "✅ WebDAV credentials configured."
fi

# Generate JWT secret if not set
if grep -q "^JWT_SECRET=$" .env || ! grep -q "^JWT_SECRET=" .env; then
    echo "🔑 Generating JWT secret..."
    JWT_SECRET=$(openssl rand -hex 32)
    sed -i.bak "s/^JWT_SECRET=.*/JWT_SECRET=$JWT_SECRET/" .env
    rm -f .env.bak
    echo "✅ JWT secret generated."
fi

# Generate Kratos secrets
if grep -q "^KRATOS_SECRETS_COOKIE=$" .env || ! grep -q "^KRATOS_SECRETS_COOKIE=" .env; then
    echo "🔑 Generating Kratos secrets..."
    KRATOS_SECRETS_COOKIE=$(openssl rand -hex 32)
    KRATOS_SECRETS_CIPHER=$(openssl rand -hex 32)
    
    sed -i.bak -e "s/^KRATOS_SECRETS_COOKIE=.*/KRATOS_SECRETS_COOKIE=\"$KRATOS_SECRETS_COOKIE\"/" \
               -e "s/^KRATOS_SECRETS_CIPHER=.*/KRATOS_SECRETS_CIPHER=\"$KRATOS_SECRETS_CIPHER\"/" .env
    rm -f .env.bak
    echo "✅ Kratos secrets generated."
fi

echo ""
echo "✨ Initialization complete!"
echo ""
echo "Next steps:"
echo "1. Review and update the .env file with your configuration"
echo "2. Start the services with: docker-compose up -d"
echo "3. Access the applications:"
echo "   - Public Upload: http://upload.localhost"
echo "   - Manager Dashboard: http://manager.localhost"
echo "   - Admin Dashboard: http://admin.localhost"
echo "   - Auth Service: http://auth.localhost"
echo ""
echo "To stop the services: docker-compose down"
echo "To view logs: docker-compose logs -f"
