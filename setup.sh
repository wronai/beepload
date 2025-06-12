#!/bin/bash
set -e

echo "🚀 Setting up Beepload - Ultimate Upload System"

# Create necessary directories
echo "📂 Creating required directories..."
mkdir -p services/upload-service/uploads

# Install dependencies for the upload service
echo "📦 Installing upload service dependencies..."
cd services/upload-service
npm install
cd ../..

# Install frontend dependencies
echo "🎨 Installing frontend dependencies..."
cd frontend
npm install
npm install -D tailwindcss postcss autoprefixer
npx tailwindcss init -p
cd ..

# Set permissions
echo "🔒 Setting permissions..."
chmod +x init.sh
chmod +x setup.sh

# Create .env file if it doesn't exist
if [ ! -f .env ]; then
    echo "📄 Creating .env file from template..."
    cp .env.example .env
    echo "✅ Created .env file. Please update it with your configuration."
else
    echo "ℹ️  .env file already exists. Skipping creation."
fi

echo ""
echo "✨ Setup complete!"
echo ""
echo "Next steps:"
echo "1. Review and update the .env file with your configuration"
echo "2. Start the services with: docker-compose up -d"
echo "3. Access the application at http://localhost:3000"
echo ""
echo "To stop the services: docker-compose down"
echo "To view logs: docker-compose logs -f"
