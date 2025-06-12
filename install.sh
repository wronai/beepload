    # Admin CSS
    cat > admin-frontend/src/App.css << 'EOF'
* {
  margin: 0;
  padding: 0;
  box-sizing: border-box;
}

body {
  font-family: -apple-system, BlinkMacSystemFont, 'Segoe UI', 'Roboto', 'Oxygen',
    'Ubuntu', 'Cantarell', 'Fira Sans', 'Droid Sans', 'Helvetica Neue',
    sans-serif;
  -webkit-font-smoothing: antialiased;
  -moz-osx-font-smoothing: grayscale;
  background-color: #f0f2f5;
  min-height: 100vh;
}

.admin-app {
  min-height: 100vh;
  display: flex;
  flex-direction: column;
}

.admin-header {
  background: linear-gradient(135deg, #dc3545 0%, #c82333 100%);
  color: white;
  padding: 20px 0;
  box-shadow: 0 2px 10px rgba(0, 0, 0, 0.1);
}

.header-content {
  max-width: 1200px;
  margin: 0 auto;
  padding: 0 20px;
  display: flex;
  justify-content: space-between;
  align-items: center;
}

.header-info h1 {
  font-size: 2rem;
  margin-bottom: 5px;
}

.header-info p {
  font-size: 1rem;
  opacity: 0.9;
}

.logout-btn {
  background: rgba(255, 255, 255, 0.2);
  color: white;
  border: 1px solid rgba(255, 255, 255, 0.3);
  padding: 10px 20px;
  border-radius: 6px;
  cursor: pointer;
  font-size: 0.9rem;
  transition: all 0.3s ease;
}

.logout-btn:hover {
  background: rgba(255, 255, 255, 0.1);
}

.admin-main {
  flex: 1;
  max-width: 1200px;
  margin: 0 auto;
  padding: 30px 20px;
  width: 100%;
  display: grid;
  grid-template-columns: 2fr 1fr;
  gap: 30px;
}

.config-section {
  background: white;
  border-radius: 12px;
  box-shadow: 0 2px 10px rgba(0, 0, 0, 0.1);
  overflow: hidden;
}

.section-header {
  padding: 24px;
  border-bottom: 1px solid #eee;
  background: #f8f9fa;
}

.section-header h2 {
  color: #333;
  font-size: 1.5rem;
  margin-bottom: 8px;
}

.section-header p {
  color: #666;
  font-size: 1rem;
}

.config-form {
  padding: 24px;
}

.form-grid {
  display: grid;
  grid-template-columns: repeat(auto-fit, minmax(300px, 1fr));
  gap: 20px;
  margin-bottom: 30px;
}

.form-group {
  display: flex;
  flex-direction: column;
  gap: 6px;
}

.form-group label {
  font-weight: 600;
  color: #333;
  font-size: 0.95rem;
}

.form-input {
  padding: 12px 16px;
  border: 2px solid #e0e0e0;
  border-radius: 8px;
  font-size: 1rem;
  transition: border-color 0.3s ease;
}

.form-input:focus {
  outline: none;
  border-color: #dc3545;
}

.form-group small {
  color: #666;
  font-size: 0.85rem;
}

.form-actions {
  display: flex;
  gap: 12px;
  padding-top: 20px;
  border-top: 1px solid #eee;
}

.save-btn,
.test-btn {
  padding: 12px 24px;
  border-radius: 8px;
  font-size: 1rem;
  font-weight: 600;
  cursor: pointer;
  transition: all 0.3s ease;
  border: none;
  display: flex;
  align-items: center;
  gap: 8px;
  justify-content: center;
  min-width: 140px;
}

.save-btn {
  background: #28a745;
  color: white;
}

.save-btn:hover:not(:disabled) {
  background: #218838;
  transform: translateY(-2px);
  box-shadow: 0 4px 12px rgba(40, 167, 69, 0.3);
}

.test-btn {
  background: #6c757d;
  color: white;
}

.test-btn:hover:not(:disabled) {
  background: #5a6268;
  transform: translateY(-2px);
  box-shadow: 0 4px 12px rgba(108, 117, 125, 0.3);
}

.save-btn:disabled,
.test-btn:disabled {
  opacity: 0.6;
  cursor: not-allowed;
  transform: none;
}

.spinner-small {
  width: 16px;
  height: 16px;
  border: 2px solid currentColor;
  border-top: 2px solid transparent;
  border-radius: 50%;
  animation: spin 1s linear infinite;
}

.spinner-large {
  width: 40px;
  height: 40px;
  border: 3px solid #f3f3f3;
  border-top: 3px solid #dc3545;
  border-radius: 50%;
  animation: spin 1s linear infinite;
  margin: 0 auto 20px;
}

@keyframes spin {
  0% { transform: rotate(0deg); }
  100% { transform: rotate(360deg); }
}

.test-result {
  margin-top: 20px;
  padding: 16px;
  border-radius: 8px;
  display: flex;
  align-items: center;
  gap: 12px;
}

.test-result.success {
  background-color: #d4edda;
  border: 1px solid #c3e6cb;
  color: #155724;
}

.test-result.error {
  background-color: #f8d7da;
  border: 1px solid #f5c6cb;
  color: #721c24;
}

.result-icon {
  font-size: 1.25rem;
}

.result-message {
  font-weight: 500;
}

.config-info {
  margin-top: 20px;
  padding-top: 20px;
  border-top: 1px solid #eee;
  color: #666;
  font-size: 0.9rem;
}

.config-info p {
  margin-bottom: 4px;
}

.help-section {
  background: white;
  border-radius: 12px;
  box-shadow: 0 2px 10px rgba(0, 0, 0, 0.1);
  padding: 24px;
  height: fit-content;
}

.help-section h3 {
  color: #333;
  margin-bottom: 20px;
  font-size: 1.25rem;
}

.help-content {
  display: flex;
  flex-direction: column;
  gap: 20px;
}

.help-item {
  padding: 16px;
  background: #f8f9fa;
  border-radius: 8px;
  border-left: 4px solid #dc3545;
}

.help-item h4 {
  color: #333;
  margin-bottom: 8px;
  font-size: 1rem;
}

.help-item ul {
  list-style: none;
  padding: 0;
}

.help-item li {
  color: #666;
  font-size: 0.9rem;
  margin-bottom: 4px;
  padding-left: 16px;
  position: relative;
}

.help-item li:before {
  content: "•";
  color: #dc3545;
  position: absolute;
  left: 0;
}

.loading-container {
  display: flex;
  flex-direction: column;
  align-items: center;
  justify-content: center;
  min-height: 100vh;
  color: #666;
}

.admin-footer {
  background: #f8f9fa;
  text-align: center;
  padding: 20px;
  color: #666;
  border-top: 1px solid #eee;
  margin-top: auto;
}

@media (max-width: 1024px) {
  .admin-main {
    grid-template-columns: 1fr;
    gap: 20px;
  }
}

@media (max-width: 768px) {
  .header-content {
    flex-direction: column;
    gap: 15px;
    text-align: center;
  }
  
  .form-grid {
    grid-template-columns: 1fr;
  }
  
  .form-actions {
    flex-direction: column;
  }
  
  .save-btn,
  .test-btn {
    width: 100%;
  }
}
EOF

    # Copy common files
    cp frontend/src/index.js admin-frontend/src/
    cp frontend/public/index.html admin-frontend/public/
    cp frontend/Dockerfile admin-frontend/
    cp frontend/nginx.conf admin-frontend/
}

# Generate deployment scripts
generate_scripts() {
    print_step "Generating deployment scripts"
    
    # Quick start script
    cat > scripts/quick-start.sh << 'EOF'
#!/bin/bash
# Quick start script for Ultimate Upload System

set -e

echo "🚀 Starting Ultimate Upload System..."

# Check if .env exists
if [ ! -f .env ]; then
    echo "📝 Creating .env from template..."
    cp .env.example .env
fi

# Start services
echo "🐳 Starting Docker services..."
docker-compose up -d

echo "⏳ Waiting for services to be ready..."
sleep 30

# Create initial users
echo "👤 Creating initial admin and manager users..."
docker-compose exec -T auth-service npm run create-admin

echo "✅ Ultimate Upload System is ready!"
echo ""
echo "📱 Access URLs:"
echo "   Public Upload:     http://upload.localhost"
echo "   Manager Dashboard: http://manager.localhost"
echo "   Admin Panel:       http://admin.localhost"
echo "   WebDAV Files:      http://files.localhost"
echo ""
echo "🔐 Login Credentials:"
echo "   Admin:   admin@company.com / admin123"
echo "   Manager: manager@company.com / manager123"
echo ""
echo "📋 To view logs: docker-compose logs -f"
echo "🛑 To stop: docker-compose down"
EOF

    chmod +x scripts/quick-start.sh

    # VPS deployment script
    cat > scripts/deploy-vps.sh << 'EOF'
#!/bin/bash
# VPS deployment script

set -e

echo "🌐 Deploying Ultimate Upload System to VPS..."

# Prompt for domain configuration
read -p "Enter your domain (e.g., yourdomain.com): " DOMAIN

if [ -z "$DOMAIN" ]; then
    echo "❌ Domain is required for VPS deployment"
    exit 1
fi

# Update .env for production
cat > .env << EOF
ENVIRONMENT=production
FRONTEND_DOMAIN=upload.$DOMAIN
API_DOMAIN=api.$DOMAIN
MANAGER_DOMAIN=manager.$DOMAIN
ADMIN_DOMAIN=admin.$DOMAIN
AUTH_DOMAIN=auth.$DOMAIN
WEBDAV_DOMAIN=files.$DOMAIN
HTTP_PORT=80
HTTPS_PORT=443
NODE_ENV=production
PYTHON_ENV=production
GROOVY_ENV=production
JWT_SECRET=$(openssl rand -base64 32)
POSTGRES_PASSWORD=$(openssl rand -base64 16)
KRATOS_DB_PASSWORD=$(openssl rand -base64 16)
CONFIG_DB_PASSWORD=$(openssl rand -base64 16)
UPLOAD_DB_PASSWORD=$(openssl rand -base64 16)
EOF

echo "✅ Production environment configured for domain: $DOMAIN"

# Install Docker if not present
if ! command -v docker &> /dev/null; then
    echo "🐳 Installing Docker..."
    curl -fsSL https://get.docker.com -o get-docker.sh
    sh get-docker.sh
    usermod -aG docker $USER
fi

# Install Docker Compose if not present
if ! command -v docker-compose &> /dev/null; then
    echo "🐙 Installing Docker Compose..."
    curl -L "https://github.com/docker/compose/releases/latest/download/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
    chmod +x /usr/local/bin/docker-compose
fi

# Build and start services
echo "🏗️ Building and starting services..."
docker-compose build
docker-compose up -d

echo "⏳ Waiting for services to be ready..."
sleep 60

# Create initial users
echo "👤 Creating initial users..."
docker-compose exec -T auth-service npm run create-admin

echo "✅ VPS deployment completed!"
echo ""
echo "📱 Your upload system is available at:"
echo "   Public Upload:     https://upload.$DOMAIN"
echo "   Manager Dashboard: https://manager.$DOMAIN"
echo "   Admin Panel:       https://admin.$DOMAIN"
echo "   WebDAV Files:      https://files.$DOMAIN"
echo ""
echo "🔐 Login Credentials:"
echo "   Admin:   admin@company.com / admin123"
echo "   Manager: manager@company.com / manager123"
echo ""
echo "⚠️  Important: Change default passwords after first login!"
EOF

    chmod +x scripts/deploy-vps.sh

    # Development script
    cat > scripts/dev.sh << 'EOF'
#!/bin/bash
# Development mode script

set -e

echo "💻 Starting development mode..."

# Start infrastructure services only
docker-compose up -d postgres redis webdav caddy

echo "🔧 Infrastructure services started. You can now run individual services locally:"
echo ""
echo "Upload Service:       cd services/upload-service && npm run dev"
echo "Approval Service:     cd services/approval-service && ./gradlew bootRun"
echo "Config Service:       cd services/config-service && python src/main.py"
echo "Notification Service: cd services/notification-service && npm run dev"
echo "Auth Service:         cd services/auth-service && npm run dev"
echo ""
echo "Frontends:"
echo "Public Frontend:      cd frontend && npm start"
echo "Manager Frontend:     cd manager-frontend && npm start"
echo "Admin Frontend:       cd admin-frontend && npm start"
EOF

    chmod +x scripts/dev.sh

    # Cleanup script
    cat > scripts/cleanup.sh << 'EOF'
#!/bin/bash
# Cleanup script

echo "🧹 Cleaning up Ultimate Upload System..."

# Stop and remove containers
docker-compose down

# Remove volumes (optional)
read -p "Remove all data volumes? (y/N): " -n 1 -r
echo
if [[ $REPLY =~ ^[Yy]$ ]]; then
    docker-compose down -v
    echo "🗑️ All volumes removed"
fi

# Remove images (optional)
read -p "Remove built images? (y/N): " -n 1 -r
echo
if [[ $REPLY =~ ^[Yy]$ ]]; then
    docker-compose down --rmi all
    echo "🗑️ All images removed"
fi

echo "✅ Cleanup completed"
EOF

    chmod +x scripts/cleanup.sh

    print_success "Deployment scripts generated"
}

# Generate documentation
generate_documentation() {
    print_step "Generating project documentation"
    
    # README.md
    cat > README.md << 'EOF'
# Ultimate Upload System

A complete file upload system with **infrastructure separation architecture** demonstrating clean separation between business logic and authorization layers.

## 🚀 Features

- **🔓 Public File Upload** - No authentication required for uploading
- **👨‍💼 Manager Approval** - Files require manager approval before download
- **⚙️ Admin Configuration** - Email settings configurable by admin users
- **📧 Email Notifications** - Automatic notifications on approval/rejection
- **💾 WebDAV Storage** - File storage with web interface
- **🔒 External Authentication** - Auth handled at infrastructure level
- **🌐 Domain Flexibility** - Easy domain/port changes via environment variables

## 🏗️ Architecture

### Infrastructure Separation
- **Caddy Proxy** - Handles routing, HTTPS, and authentication
- **External Auth Service** - Manages user authentication and authorization
- **Business Services** - Pure business logic with no auth code
- **WebDAV Storage** - File storage separated from application logic

### Services
- **Upload Service** (Node.js) - Handles file uploads
- **Approval Service** (Groovy) - Manages approval workflow
- **Config Service** (Python) - System configuration management
- **Notification Service** (Node.js) - Email notifications
- **Auth Service** (Node.js) - External authentication provider

### Frontends
- **Public Frontend** (React) - Public upload interface
- **Manager Frontend** (React) - Manager approval dashboard
- **Admin Frontend** (React) - Admin configuration panel

## 🚀 Quick Start

### Prerequisites
- Docker and Docker Compose
- Git

### Local Development

```bash
# 1. Run the installer
./install.sh

# 2. Quick start
cd ultimate-upload-system
./scripts/quick-start.sh

# 3. Access the applications
# Public Upload:     http://upload.localhost
# Manager Dashboard: http://manager.localhost (admin@company.com / admin123)
# Admin Panel:       http://admin.localhost (admin@company.com / admin123)
# WebDAV Files:      http://files.localhost
```

### VPS Deployment

```bash
# 1. Run the installer on your VPS
./install.sh

# 2. Deploy to production
cd ultimate-upload-system
./scripts/deploy-vps.sh

# Follow the prompts to configure your domain
```

## 🔧 Configuration

### Environment Variables

The system uses environment variables for complete flexibility:

```bash
# Domains (change for different environments)
FRONTEND_DOMAIN=upload.localhost
API_DOMAIN=api.localhost
MANAGER_DOMAIN=manager.localhost
ADMIN_DOMAIN=admin.localhost
AUTH_DOMAIN=auth.localhost
WEBDAV_DOMAIN=files.localhost

# Ports (change for multi-server setups)
HTTP_PORT=80
HTTPS_PORT=443

# Security
JWT_SECRET=your-secret-key
POSTGRES_PASSWORD=your-db-password
```

### Production Example

```bash
# Production domains
FRONTEND_DOMAIN=upload.mycompany.com
API_DOMAIN=api.mycompany.com
MANAGER_DOMAIN=manager.mycompany.com
ADMIN_DOMAIN=admin.mycompany.com
```

## 📁 Project Structure

```
ultimate-upload-system/
├── docker-compose.yml          # Complete infrastructure setup
├── Caddyfile                   # Reverse proxy + auth configuration
├── .env                        # Environment configuration
├── services/
│   ├── upload-service/         # Node.js upload handler
│   ├── approval-service/       # Groovy approval workflow
│   ├── config-service/         # Python configuration management
│   ├── notification-service/   # Node.js email notifications
│   └── auth-service/           # External authentication
├── frontend/                   # React public upload app
├── manager-frontend/          # React manager dashboard
├── admin-frontend/            # React admin panel
└── scripts/                   # Deployment and utility scripts
```

## 🔐 Authentication & Authorization

### Key Principles

1. **Zero Auth Logic in Business Services** - All authentication handled by Caddy proxy
2. **Header-Based User Context** - Services receive user info via HTTP headers
3. **Role-Based Access Control** - Manager and Admin roles with different permissions
4. **External Auth Provider** - Dedicated service for authentication logic

### User Roles

- **Public Users** - Can upload files (no account required)
- **Managers** - Can approve/reject uploaded files
- **Admins** - Can configure system settings + manager permissions

### Default Credentials

```
Admin:   admin@company.com / admin123
Manager: manager@company.com / manager123
```

⚠️ **Change these passwords immediately in production!**

## 📧 Email Configuration

Configure SMTP settings through the admin panel:

1. Login to admin panel: `http://admin.localhost`
2. Navigate to Email Configuration
3. Enter your SMTP settings
4. Test the configuration
5. Save settings

### Supported Providers

- **Gmail** - Use app-specific passwords
- **Outlook/Hotmail** - Standard credentials
- **Custom SMTP** - Any SMTP server

## 🔄 Workflow

1. **User uploads file** → Public interface (no auth required)
2. **File stored** → WebDAV storage + database record
3. **Manager notified** → File appears in pending queue
4. **Manager reviews** → Preview file and approve/reject
5. **Email sent** → User notified of decision
6. **File available** → Approved files can be downloaded

## 🛠️ Development

### Local Development Mode

```bash
# Start infrastructure only
./scripts/dev.sh

# Run services individually
cd services/upload-service && npm run dev
cd services/approval-service && ./gradlew bootRun
cd services/config-service && python src/main.py
```

### Building Services

```bash
# Build all services
docker-compose build

# Build specific service
docker-compose build upload-service
```

### Logs

```bash
# View all logs
docker-compose logs -f

# View specific service logs
docker-compose logs -f upload-service
```

## 🌐 Production Deployment

### Requirements

- VPS with Docker support
- Domain name with DNS configured
- SSL certificates (handled automatically by Caddy)

### Steps

1. Point your domain's DNS to your VPS IP
2. Run the installer script
3. Use the VPS deployment script
4. Configure email settings through admin panel
5. Change default passwords

### Scaling

The architecture supports horizontal scaling:

- Load balance multiple instances behind Caddy
- Use external database (PostgreSQL)
- Use external Redis cluster
- Use external file storage (S3, etc.)

## 🔧 Troubleshooting

### Common Issues

**Services not starting:**
```bash
# Check Docker logs
docker-compose logs

# Restart services
docker-compose restart
```

**Domain not resolving:**
```bash
# Add to /etc/hosts for local development
127.0.0.1 upload.localhost api.localhost manager.localhost admin.localhost
```

**Email not working:**
```bash
# Test email configuration in admin panel
# Check notification service logs
docker-compose logs notification-service
```

### Reset Everything

```bash
# Complete reset (removes all data)
./scripts/cleanup.sh
```

## 🤝 Contributing

1. Fork the repository
2. Create a feature branch
3. Make your changes
4. Test thoroughly
5. Submit a pull request

## 📄 License

This project is licensed under the MIT License.

## 🙏 Acknowledgments

- Built with modern infrastructure separation principles
- Demonstrates clean architecture patterns
- Inspired by microservices and domain-driven design
EOF

    # API Documentation
    cat > docs/API.md << 'EOF'
# API Documentation

## Authentication

All protected endpoints require authentication via:
- JWT Bearer token in Authorization header
- Session cookie (managed by auth service)

Authentication is handled by Caddy proxy, which forwards user context via headers:
- `X-User-ID` - User identifier
- `X-User-Email` - User email address
- `X-User-Roles` - JSON array of user roles
- `X-Manager-ID` - Manager identifier (for manager endpoints)
- `X-Admin-ID` - Admin identifier (for admin endpoints)

## Upload Service

### Upload File (Public)
```
POST /uploads
Content-Type: multipart/form-data

Form data:
- file: File to upload
- description: Optional description
- uploaderEmail: Email for notifications

Response:
{
  "success": true,
  "uploadId": "123",
  "filename": "timestamp_filename.ext",
  "message": "File uploaded successfully and pending approval"
}
```

### Download File (Public)
```
GET /files/{filename}

Response: File stream (if approved)
```

## Approval Service

### Get Pending Uploads (Manager)
```
GET /approval/pending

Response:
{
  "success": true,
  "uploads": [...],
  "managedBy": "manager@company.com",
  "count": 5
}
```

### Approve Upload (Manager)
```
POST /approval/approve/{uploadId}

Response:
{
  "success": true,
  "message": "Upload approved successfully",
  "uploadId": "123",
  "approvedBy": "manager@company.com"
}
```

### Reject Upload (Manager)
```
POST /approval/reject/{uploadId}

Body:
{
  "reason": "Reason for rejection"
}

Response:
{
  "success": true,
  "message": "Upload rejected",
  "reason": "Reason for rejection",
  "rejectedBy": "manager@company.com"
}
```

## Config Service

### Get Email Configuration (Admin)
```
GET /config/email

Response:
{
  "smtp_host": "smtp.gmail.com",
  "smtp_port": 587,
  "smtp_username": "user@gmail.com",
  "from_email": "noreply@company.com",
  "from_name": "Upload System",
  "updated_by": "admin@company.com",
  "updated_at": "2024-01-15T12:00:00Z"
}
```

### Update Email Configuration (Admin)
```
PUT /config/email

Body:
{
  "smtp_host": "smtp.gmail.com",
  "smtp_port": 587,
  "smtp_username": "user@gmail.com",
  "smtp_password": "password",
  "from_email": "noreply@company.com",
  "from_name": "Upload System"
}

Response:
{
  "success": true,
  "message": "Email configuration updated successfully",
  "updated_by": "admin@company.com",
  "updated_fields": ["smtp_host", "smtp_port"]
}
```

### Test Email Configuration (Admin)
```
POST /config/email/test

Response:
{
  "success": true,
  "message": "Test email sent successfully to admin@company.com"
}
```

## Auth Service

### Login
```
POST /login

Body:
{
  "email": "user@company.com",
  "password": "password"
}

Response:
{
  "success": true,
  "token": "jwt-token-here",
  "user": {
    "id": "user-123",
    "email": "user@company.com",
    "roles": ["manager"]
  }
}
```

### Logout
```
POST /logout

Response:
{
  "success": true,
  "message": "Logged out successfully"
}
```

### Verify Manager (Internal)
```
GET /verify-manager
Authorization: Bearer <token>

Response:
{
  "success": true,
  "user": "manager@company.com"
}

Headers (forwarded by Caddy):
- X-User-ID: user-123
- X-User-Email: manager@company.com
- X-User-Roles: ["manager"]
- X-Manager-ID: user-123
```

### Verify Admin (Internal)
```
GET /verify-admin
Authorization: Bearer <token>

Response:    # Public HTML
    cat > frontend/public/index.html << 'EOF'
<!DOCTYPE html>
<html lang="en">
  <head>
    <meta charset="utf-8" />
    <link rel="icon" href="%PUBLIC_URL%/favicon.ico" />
    <meta name="viewport" content="width=device-width, initial-scale=1" />
    <meta name="theme-color" content="#000000" />
    <meta name="description" content="Ultimate Upload System - Infrastructure Separation Architecture" />
    <title>Ultimate Upload System</title>
  </head>
  <body>
    <noscript>You need to enable JavaScript to run this app.</noscript>
    <div id="root"></div>
  </body>
</html>
EOF

    # Dockerfile
    cat > frontend/Dockerfile << 'EOF'
# Build stage
FROM node:18-alpine AS build

WORKDIR /app

# Copy package files
COPY package*.json ./

# Install dependencies
RUN npm ci --only=production

# Copy source code
COPY src/ ./src/
COPY public/ ./public/

# Build application
RUN npm run build

# Production stage
FROM nginx:alpine

# Copy built app
COPY --from=build /app/build /usr/share/nginx/html

# Copy nginx configuration
COPY nginx.conf /etc/nginx/nginx.conf

# Expose port
EXPOSE 3000

# Health check
HEALTHCHECK --interval=30s --timeout=3s --start-period=5s --retries=3 \
  CMD curl -f http://localhost:3000 || exit 1

# Start nginx
CMD ["nginx", "-g", "daemon off;"]
EOF

    # Nginx config
    cat > frontend/nginx.conf << 'EOF'
events {
    worker_connections 1024;
}

http {
    include /etc/nginx/mime.types;
    default_type application/octet-stream;

    server {
        listen 3000;
        server_name localhost;
        root /usr/share/nginx/html;
        index index.html;

        location / {
            try_files $uri $uri/ /index.html;
        }

        location /health {
            access_log off;
            return 200 "healthy\n";
            add_header Content-Type text/plain;
        }
    }
}
EOF
}

# Generate Manager Frontend
generate_manager_frontend() {
    # Package.json (similar to public frontend)
    cat > manager-frontend/package.json << 'EOF'
{
  "name": "manager-frontend",
  "version": "1.0.0",
  "private": true,
  "dependencies": {
    "react": "^18.2.0",
    "react-dom": "^18.2.0",
    "react-scripts": "5.0.1",
    "axios": "^1.6.0",
    "react-router-dom": "^6.18.0",
    "web-vitals": "^3.5.0"
  },
  "scripts": {
    "start": "react-scripts start",
    "build": "react-scripts build",
    "test": "react-scripts test",
    "eject": "react-scripts eject"
  },
  "eslintConfig": {
    "extends": [
      "react-app",
      "react-app/jest"
    ]
  },
  "browserslist": {
    "production": [
      ">0.2%",
      "not dead",
      "not op_mini all"
    ],
    "development": [
      "last 1 chrome version",
      "last 1 firefox version",
      "last 1 safari version"
    ]
  }
}
EOF

    # Manager App
    cat > manager-frontend/src/App.js << 'EOF'
import React, { useState, useEffect } from 'react';
import axios from 'axios';
import './App.css';

const API_URL = process.env.REACT_APP_API_URL || 'http://api.localhost';
const AUTH_URL = process.env.REACT_APP_AUTH_URL || 'http://auth.localhost';

function App() {
  const [user, setUser] = useState(null);
  const [pendingUploads, setPendingUploads] = useState([]);
  const [loading, setLoading] = useState(true);
  const [actionLoading, setActionLoading] = useState({});

  useEffect(() => {
    // Check if user is logged in
    const token = localStorage.getItem('authToken');
    if (token) {
      loadPendingUploads();
    } else {
      redirectToLogin();
    }
  }, []);

  const redirectToLogin = () => {
    const currentUrl = encodeURIComponent(window.location.href);
    window.location.href = `${AUTH_URL}/login?redirect=${currentUrl}`;
  };

  const loadPendingUploads = async () => {
    try {
      setLoading(true);
      
      const response = await axios.get(`${API_URL}/approval/pending`, {
        headers: {
          'Authorization': `Bearer ${localStorage.getItem('authToken')}`
        }
      });
      
      setPendingUploads(response.data.uploads);
      setUser({ email: response.data.managedBy });
      
    } catch (error) {
      if (error.response?.status === 401) {
        localStorage.removeItem('authToken');
        redirectToLogin();
      } else {
        console.error('Failed to load uploads:', error);
        alert('Failed to load pending uploads');
      }
    } finally {
      setLoading(false);
    }
  };

  const setActionLoadingState = (uploadId, state) => {
    setActionLoading(prev => ({
      ...prev,
      [uploadId]: state
    }));
  };

  const approveUpload = async (uploadId) => {
    try {
      setActionLoadingState(uploadId, 'approving');
      
      await axios.post(`${API_URL}/approval/approve/${uploadId}`, {}, {
        headers: {
          'Authorization': `Bearer ${localStorage.getItem('authToken')}`
        }
      });
      
      // Reload list
      loadPendingUploads();
      
    } catch (error) {
      console.error('Failed to approve upload:', error);
      alert('Failed to approve upload');
    } finally {
      setActionLoadingState(uploadId, null);
    }
  };

  const rejectUpload = async (uploadId) => {
    const reason = prompt('Please provide a reason for rejection:');
    if (!reason || reason.trim() === '') {
      return;
    }
    
    try {
      setActionLoadingState(uploadId, 'rejecting');
      
      await axios.post(`${API_URL}/approval/reject/${uploadId}`, { reason: reason.trim() }, {
        headers: {
          'Authorization': `Bearer ${localStorage.getItem('authToken')}`
        }
      });
      
      // Reload list
      loadPendingUploads();
      
    } catch (error) {
      console.error('Failed to reject upload:', error);
      alert('Failed to reject upload');
    } finally {
      setActionLoadingState(uploadId, null);
    }
  };

  const logout = () => {
    localStorage.removeItem('authToken');
    window.location.href = AUTH_URL;
  };

  const formatFileSize = (bytes) => {
    if (bytes === 0) return '0 Bytes';
    const k = 1024;
    const sizes = ['Bytes', 'KB', 'MB', 'GB'];
    const i = Math.floor(Math.log(bytes) / Math.log(k));
    return parseFloat((bytes / Math.pow(k, i)).toFixed(2)) + ' ' + sizes[i];
  };

  const formatDate = (dateString) => {
    return new Date(dateString).toLocaleString();
  };

  if (loading) {
    return (
      <div className="loading-container">
        <div className="spinner-large"></div>
        <p>Loading pending uploads...</p>
      </div>
    );
  }

  return (
    <div className="manager-app">
      <header className="manager-header">
        <div className="header-content">
          <div className="header-info">
            <h1>📋 Manager Dashboard</h1>
            <p>Logged in as: <strong>{user?.email}</strong></p>
          </div>
          <button onClick={logout} className="logout-btn">
            Logout
          </button>
        </div>
      </header>
      
      <main className="manager-main">
        <div className="dashboard-stats">
          <div className="stat-card">
            <div className="stat-number">{pendingUploads.length}</div>
            <div className="stat-label">Pending Uploads</div>
          </div>
        </div>

        <section className="uploads-section">
          <div className="section-header">
            <h2>Pending Uploads</h2>
            <button onClick={loadPendingUploads} className="refresh-btn">
              🔄 Refresh
            </button>
          </div>
          
          {pendingUploads.length === 0 ? (
            <div className="empty-state">
              <div className="empty-icon">📭</div>
              <h3>No pending uploads</h3>
              <p>All caught up! No files waiting for approval.</p>
            </div>
          ) : (
            <div className="uploads-grid">
              {pendingUploads.map(upload => (
                <div key={upload.id} className="upload-card">
                  <div className="upload-header">
                    <div className="file-icon">📄</div>
                    <div className="upload-info">
                      <h3 className="file-name">{upload.originalName}</h3>
                      <p className="file-size">{formatFileSize(upload.size)}</p>
                    </div>
                  </div>
                  
                  <div className="upload-details">
                    <div className="detail-row">
                      <span className="label">Uploaded by:</span>
                      <span className="value">{upload.uploaderEmail}</span>
                    </div>
                    
                    <div className="detail-row">
                      <span className="label">Uploaded:</span>
                      <span className="value">{formatDate(upload.uploadedAt)}</span>
                    </div>
                    
                    {upload.description && (
                      <div className="detail-row">
                        <span className="label">Description:</span>
                        <span className="value">{upload.description}</span>
                      </div>
                    )}
                    
                    <div className="detail-row">
                      <span className="label">Type:</span>
                      <span className="value">{upload.mimetype}</span>
                    </div>
                  </div>
                  
                  <div className="upload-actions">
                    <button 
                      onClick={() => approveUpload(upload.id)}
                      disabled={actionLoading[upload.id]}
                      className="approve-btn"
                    >
                      {actionLoading[upload.id] === 'approving' ? (
                        <>
                          <span className="spinner-small"></span>
                          Approving...
                        </>
                      ) : (
                        <>
                          ✅ Approve
                        </>
                      )}
                    </button>
                    
                    <button 
                      onClick={() => rejectUpload(upload.id)}
                      disabled={actionLoading[upload.id]}
                      className="reject-btn"
                    >
                      {actionLoading[upload.id] === 'rejecting' ? (
                        <>
                          <span className="spinner-small"></span>
                          Rejecting...
                        </>
                      ) : (
                        <>
                          ❌ Reject
                        </>
                      )}
                    </button>
                    
                    <a 
                      href={`https://files.localhost/${upload.filename}`}
                      target="_blank" 
                      rel="noopener noreferrer"
                      className="preview-btn"
                    >
                      👁️ Preview
                    </a>
                  </div>
                </div>
              ))}
            </div>
          )}
        </section>
      </main>
      
      <footer className="manager-footer">
        <p>Ultimate Upload System - Manager Dashboard</p>
      </footer>
    </div>
  );
}

export default App;
EOF

    # Manager CSS
    cat > manager-frontend/src/App.css << 'EOF'
* {
  margin: 0;
  padding: 0;
  box-sizing: border-box;
}

body {
  font-family: -apple-system, BlinkMacSystemFont, 'Segoe UI', 'Roboto', 'Oxygen',
    'Ubuntu', 'Cantarell', 'Fira Sans', 'Droid Sans', 'Helvetica Neue',
    sans-serif;
  -webkit-font-smoothing: antialiased;
  -moz-osx-font-smoothing: grayscale;
  background-color: #f5f5f5;
  min-height: 100vh;
}

.manager-app {
  min-height: 100vh;
  display: flex;
  flex-direction: column;
}

.manager-header {
  background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
  color: white;
  padding: 20px 0;
  box-shadow: 0 2px 10px rgba(0, 0, 0, 0.1);
}

.header-content {
  max-width: 1200px;
  margin: 0 auto;
  padding: 0 20px;
  display: flex;
  justify-content: space-between;
  align-items: center;
}

.header-info h1 {
  font-size: 2rem;
  margin-bottom: 5px;
}

.header-info p {
  font-size: 1rem;
  opacity: 0.9;
}

.logout-btn {
  background: rgba(255, 255, 255, 0.2);
  color: white;
  border: 1px solid rgba(255, 255, 255, 0.3);
  padding: 10px 20px;
  border-radius: 6px;
  cursor: pointer;
  font-size: 0.9rem;
  transition: all 0.3s ease;
}

.logout-btn:hover {
  background: rgba(255, 255, 255, 0.1);
}

.manager-main {
  flex: 1;
  max-width: 1200px;
  margin: 0 auto;
  padding: 30px 20px;
  width: 100%;
}

.dashboard-stats {
  margin-bottom: 30px;
}

.stat-card {
  background: white;
  padding: 24px;
  border-radius: 8px;
  box-shadow: 0 2px 8px rgba(0, 0, 0, 0.1);
  text-align: center;
  display: inline-block;
}

.stat-number {
  font-size: 3rem;
  font-weight: bold;
  color: #667eea;
  margin-bottom: 5px;
}

.stat-label {
  color: #666;
  font-size: 1.1rem;
}

.uploads-section {
  background: white;
  border-radius: 8px;
  box-shadow: 0 2px 8px rgba(0, 0, 0, 0.1);
  overflow: hidden;
}

.section-header {
  padding: 20px 24px;
  border-bottom: 1px solid #eee;
  display: flex;
  justify-content: space-between;
  align-items: center;
}

.section-header h2 {
  color: #333;
  font-size: 1.5rem;
}

.refresh-btn {
  background: #f8f9fa;
  border: 1px solid #dee2e6;
  padding: 8px 16px;
  border-radius: 6px;
  cursor: pointer;
  font-size: 0.9rem;
  transition: all 0.3s ease;
}

.refresh-btn:hover {
  background: #e9ecef;
}

.empty-state {
  text-align: center;
  padding: 60px 20px;
  color: #666;
}

.empty-icon {
  font-size: 4rem;
  margin-bottom: 20px;
}

.empty-state h3 {
  margin-bottom: 10px;
  color: #333;
}

.uploads-grid {
  padding: 24px;
  display: grid;
  grid-template-columns: repeat(auto-fill, minmax(400px, 1fr));
  gap: 20px;
}

.upload-card {
  border: 1px solid #eee;
  border-radius: 8px;
  padding: 20px;
  background: #fafafa;
  transition: all 0.3s ease;
}

.upload-card:hover {
  box-shadow: 0 4px 12px rgba(0, 0, 0, 0.1);
  transform: translateY(-2px);
}

.upload-header {
  display: flex;
  align-items: center;
  gap: 12px;
  margin-bottom: 16px;
}

.file-icon {
  font-size: 2rem;
}

.upload-info {
  flex: 1;
}

.file-name {
  font-size: 1.1rem;
  font-weight: 600;
  color: #333;
  margin-bottom: 4px;
  word-break: break-word;
}

.file-size {
  color: #666;
  font-size: 0.9rem;
}

.upload-details {
  margin-bottom: 20px;
}

.detail-row {
  display: flex;
  margin-bottom: 8px;
  gap: 8px;
}

.detail-row .label {
  font-weight: 600;
  color: #555;
  min-width: 100px;
}

.detail-row .value {
  color: #333;
  word-break: break-word;
  flex: 1;
}

.upload-actions {
  display: flex;
  gap: 8px;
  flex-wrap: wrap;
}

.upload-actions button,
.upload-actions a {
  padding: 8px 16px;
  border-radius: 6px;
  font-size: 0.85rem;
  font-weight: 500;
  text-decoration: none;
  text-align: center;
  cursor: pointer;
  transition: all 0.3s ease;
  border: none;
  display: flex;
  align-items: center;
  gap: 4px;
  flex: 1;
  min-width: 0;
  justify-content: center;
}

.approve-btn {
  background: #28a745;
  color: white;
}

.approve-btn:hover:not(:disabled) {
  background: #218838;
}

.reject-btn {
  background: #dc3545;
  color: white;
}

.reject-btn:hover:not(:disabled) {
  background: #c82333;
}

.preview-btn {
  background: #6c757d;
  color: white;
}

.preview-btn:hover {
  background: #5a6268;
}

.upload-actions button:disabled {
  opacity: 0.6;
  cursor: not-allowed;
}

.spinner-small {
  width: 14px;
  height: 14px;
  border: 2px solid currentColor;
  border-top: 2px solid transparent;
  border-radius: 50%;
  animation: spin 1s linear infinite;
}

.spinner-large {
  width: 40px;
  height: 40px;
  border: 3px solid #f3f3f3;
  border-top: 3px solid #667eea;
  border-radius: 50%;
  animation: spin 1s linear infinite;
  margin: 0 auto 20px;
}

@keyframes spin {
  0% { transform: rotate(0deg); }
  100% { transform: rotate(360deg); }
}

.loading-container {
  display: flex;
  flex-direction: column;
  align-items: center;
  justify-content: center;
  min-height: 100vh;
  color: #666;
}

.manager-footer {
  background: #f8f9fa;
  text-align: center;
  padding: 20px;
  color: #666;
  border-top: 1px solid #eee;
}

@media (max-width: 768px) {
  .header-content {
    flex-direction: column;
    gap: 15px;
    text-align: center;
  }
  
  .uploads-grid {
    grid-template-columns: 1fr;
    padding: 16px;
  }
  
  .upload-actions {
    flex-direction: column;
  }
  
  .upload-actions button,
  .upload-actions a {
    flex: none;
  }
}
EOF

    # Dockerfile and nginx config (similar to public frontend)
    cp frontend/Dockerfile manager-frontend/
    cp frontend/nginx.conf manager-frontend/
    cp frontend/src/index.js manager-frontend/src/
    cp frontend/public/index.html manager-frontend/public/
}

# Generate Admin Frontend
generate_admin_frontend() {
    # Package.json (similar structure)
    cat > admin-frontend/package.json << 'EOF'
{
  "name": "admin-frontend",
  "version": "1.0.0",
  "private": true,
  "dependencies": {
    "react": "^18.2.0",
    "react-dom": "^18.2.0",
    "react-scripts": "5.0.1",
    "axios": "^1.6.0",
    "react-router-dom": "^6.18.0",
    "web-vitals": "^3.5.0"
  },
  "scripts": {
    "start": "react-scripts start",
    "build": "react-scripts build",
    "test": "react-scripts test",
    "eject": "react-scripts eject"
  },
  "eslintConfig": {
    "extends": [
      "react-app",
      "react-app/jest"
    ]
  },
  "browserslist": {
    "production": [
      ">0.2%",
      "not dead",
      "not op_mini all"
    ],
    "development": [
      "last 1 chrome version",
      "last 1 firefox version",
      "last 1 safari version"
    ]
  }
}
EOF

    # Admin App
    cat > admin-frontend/src/App.js << 'EOF'
import React, { useState, useEffect } from 'react';
import axios from 'axios';
import './App.css';

const API_URL = process.env.REACT_APP_API_URL || 'http://api.localhost';
const AUTH_URL = process.env.REACT_APP_AUTH_URL || 'http://auth.localhost';

function App() {
  const [user, setUser] = useState(null);
  const [emailConfig, setEmailConfig] = useState({
    smtp_host: '',
    smtp_port: 587,
    smtp_username: '',
    smtp_password: '',
    from_email: '',
    from_name: ''
  });
  const [loading, setLoading] = useState(true);
  const [saving, setSaving] = useState(false);
  const [testing, setTesting] = useState(false);
  const [testResult, setTestResult] = useState(null);

  useEffect(() => {
    const token = localStorage.getItem('authToken');
    if (token) {
      loadEmailConfig();
    } else {
      redirectToLogin();
    }
  }, []);

  const redirectToLogin = () => {
    const currentUrl = encodeURIComponent(window.location.href);
    window.location.href = `${AUTH_URL}/login?redirect=${currentUrl}`;
  };

  const loadEmailConfig = async () => {
    try {
      setLoading(true);
      
      const response = await axios.get(`${API_URL}/config/email`, {
        headers: {
          'Authorization': `Bearer ${localStorage.getItem('authToken')}`
        }
      });
      
      setEmailConfig({
        smtp_host: response.data.smtp_host || '',
        smtp_port: response.data.smtp_port || 587,
        smtp_username: response.data.smtp_username || '',
        smtp_password: '',
        from_email: response.data.from_email || '',
        from_name: response.data.from_name || ''
      });
      
      setUser({ 
        email: 'admin@company.com',
        updatedBy: response.data.updated_by,
        updatedAt: response.data.updated_at
      });
      
    } catch (error) {
      if (error.response?.status === 401) {
        localStorage.removeItem('authToken');
        redirectToLogin();
      } else {
        console.error('Failed to load config:', error);
        alert('Failed to load configuration');
      }
    } finally {
      setLoading(false);
    }
  };

  const saveEmailConfig = async (e) => {
    e.preventDefault();
    
    try {
      setSaving(true);
      
      // Only send non-empty fields
      const configToSave = {};
      Object.keys(emailConfig).forEach(key => {
        if (emailConfig[key] !== '') {
          configToSave[key] = emailConfig[key];
        }
      });
      
      await axios.put(`${API_URL}/config/email`, configToSave, {
        headers: {
          'Authorization': `Bearer ${localStorage.getItem('authToken')}`
        }
      });
      
      alert('Email configuration saved successfully!');
      
      // Reload to get updated info
      loadEmailConfig();
      
    } catch (error) {
      console.error('Failed to save config:', error);
      alert('Failed to save configuration');
    } finally {
      setSaving(false);
    }
  };

  const testEmailConfig = async () => {
    try {
      setTesting(true);
      setTestResult(null);
      
      const response = await axios.post(`${API_URL}/config/email/test`, {}, {
        headers: {
          'Authorization': `Bearer ${localStorage.getItem('authToken')}`
        }
      });
      
      setTestResult({
        success: response.data.success,
        message: response.data.success 
          ? 'Test email sent successfully!' 
          : response.data.error
      });
      
    } catch (error) {
      setTestResult({
        success: false,
        message: error.response?.data?.error || 'Test email failed'
      });
    } finally {
      setTesting(false);
    }
  };

  const logout = () => {
    localStorage.removeItem('authToken');
    window.location.href = AUTH_URL;
  };

  const handleInputChange = (field, value) => {
    setEmailConfig(prev => ({
      ...prev,
      [field]: value
    }));
  };

  if (loading) {
    return (
      <div className="loading-container">
        <div className="spinner-large"></div>
        <p>Loading configuration...</p>
      </div>
    );
  }

  return (
    <div className="admin-app">
      <header className="admin-header">
        <div className="header-content">
          <div className="header-info">
            <h1>⚙️ Admin Configuration Panel</h1>
            <p>System administration and settings</p>
          </div>
          <button onClick={logout} className="logout-btn">
            Logout
          </button>
        </div>
      </header>
      
      <main className="admin-main">
        <div className="config-section">
          <div className="section-header">
            <h2>📧 Email Configuration</h2>
            <p>Configure SMTP settings for system notifications</p>
          </div>
          
          <form onSubmit={saveEmailConfig} className="config-form">
            <div className="form-grid">
              <div className="form-group">
                <label htmlFor="smtp_host">SMTP Host *</label>
                <input
                  type="text"
                  id="smtp_host"
                  value={emailConfig.smtp_host}
                  onChange={(e) => handleInputChange('smtp_host', e.target.value)}
                  placeholder="smtp.gmail.com"
                  required
                  className="form-input"
                />
                <small>The hostname of your SMTP server</small>
              </div>
              
              <div className="form-group">
                <label htmlFor="smtp_port">SMTP Port *</label>
                <input
                  type="number"
                  id="smtp_port"
                  value={emailConfig.smtp_port}
                  onChange={(e) => handleInputChange('smtp_port', parseInt(e.target.value) || 587)}
                  min="1"
                  max="65535"
                  required
                  className="form-input"
                />
                <small>Usually 587 for TLS or 465 for SSL</small>
              </div>
              
              <div className="form-group">
                <label htmlFor="smtp_username">SMTP Username *</label>
                <input
                  type="text"
                  id="smtp_username"
                  value={emailConfig.smtp_username}
                  onChange={(e) => handleInputChange('smtp_username', e.target.value)}
                  placeholder="your-email@domain.com"
                  required
                  className="form-input"
                />
                <small>Your SMTP authentication username</small>
              </div>
              
              <div className="form-group">
                <label htmlFor="smtp_password">SMTP Password *</label>
                <input
                  type="password"
                  id="smtp_password"
                  value={emailConfig.smtp_password}
                  onChange={(e) => handleInputChange('smtp_password', e.target.value)}
                  placeholder="Enter new password to change"
                  className="form-input"
                />
                <small>Leave empty to keep current password</small>
              </div>
              
              <div className="form-group">
                <label htmlFor="from_email">From Email *</label>
                <input
                  type="email"
                  id="from_email"
                  value={emailConfig.from_email}
                  onChange={(e) => handleInputChange('from_email', e.target.value)}
                  placeholder="noreply@company.com"
                  required
                  className="form-input"
                />
                <small>Email address that appears as sender</small>
              </div>
              
              <div className="form-group">
                <label htmlFor="from_name">From Name *</label>
                <input
                  type="text"
                  id="from_name"
                  value={emailConfig.from_name}
                  onChange={(e) => handleInputChange('from#!/bin/bash

# Ultimate Upload System - Complete Installer
# Supports local development and VPS deployment

set -e

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
PURPLE='\033[0;35m'
CYAN='\033[0;36m'
NC='\033[0m' # No Color

# Configuration
PROJECT_NAME="ultimate-upload-system"
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
PROJECT_DIR="$SCRIPT_DIR/$PROJECT_NAME"

# Functions
print_header() {
    echo -e "${PURPLE}"
    echo "╔══════════════════════════════════════════════════════════════════════════════╗"
    echo "║                    Ultimate Upload System Installer                         ║"
    echo "║                   Complete Infrastructure Separation                        ║"
    echo "╚══════════════════════════════════════════════════════════════════════════════╝"
    echo -e "${NC}"
}

print_step() {
    echo -e "${CYAN}[STEP]${NC} $1"
}

print_success() {
    echo -e "${GREEN}[SUCCESS]${NC} $1"
}

print_warning() {
    echo -e "${YELLOW}[WARNING]${NC} $1"
}

print_error() {
    echo -e "${RED}[ERROR]${NC} $1"
}

print_info() {
    echo -e "${BLUE}[INFO]${NC} $1"
}

# Check if running on VPS or local
detect_environment() {
    if [[ -n "${SSH_CLIENT}" ]] || [[ -n "${SSH_TTY}" ]] || [[ "${USER}" == "root" ]]; then
        ENVIRONMENT="vps"
        print_info "Detected VPS environment"
    else
        ENVIRONMENT="local"
        print_info "Detected local development environment"
    fi
}

# Check system requirements
check_requirements() {
    print_step "Checking system requirements"
    
    # Check if Docker is installed
    if ! command -v docker &> /dev/null; then
        print_error "Docker is not installed"
        install_docker
    else
        print_success "Docker is installed"
    fi
    
    # Check if Docker Compose is installed
    if ! command -v docker-compose &> /dev/null && ! docker compose version &> /dev/null; then
        print_error "Docker Compose is not installed"
        install_docker_compose
    else
        print_success "Docker Compose is installed"
    fi
    
    # Check if Git is installed
    if ! command -v git &> /dev/null; then
        print_error "Git is not installed"
        install_git
    else
        print_success "Git is installed"
    fi
    
    # Check if Node.js is installed (for development)
    if ! command -v node &> /dev/null; then
        print_warning "Node.js is not installed (recommended for development)"
    else
        print_success "Node.js is installed ($(node --version))"
    fi
}

# Install Docker
install_docker() {
    print_step "Installing Docker"
    
    if [[ "$OSTYPE" == "linux-gnu"* ]]; then
        # Update package index
        sudo apt-get update
        
        # Install packages to allow apt to use a repository over HTTPS
        sudo apt-get install -y \
            apt-transport-https \
            ca-certificates \
            curl \
            gnupg \
            lsb-release
        
        # Add Docker's official GPG key
        curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg
        
        # Set up the stable repository
        echo \
          "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/ubuntu \
          $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
        
        # Install Docker Engine
        sudo apt-get update
        sudo apt-get install -y docker-ce docker-ce-cli containerd.io
        
        # Add current user to docker group
        sudo usermod -aG docker $USER
        
        print_success "Docker installed successfully"
        print_warning "Please logout and login again to use Docker without sudo"
        
    elif [[ "$OSTYPE" == "darwin"* ]]; then
        print_info "Please install Docker Desktop for Mac from https://www.docker.com/products/docker-desktop"
        exit 1
    else
        print_error "Unsupported operating system for automatic Docker installation"
        exit 1
    fi
}

# Install Docker Compose
install_docker_compose() {
    print_step "Installing Docker Compose"
    
    # Get latest version
    DOCKER_COMPOSE_VERSION=$(curl -s https://api.github.com/repos/docker/compose/releases/latest | grep tag_name | cut -d '"' -f 4)
    
    # Download and install
    sudo curl -L "https://github.com/docker/compose/releases/download/${DOCKER_COMPOSE_VERSION}/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
    sudo chmod +x /usr/local/bin/docker-compose
    
    print_success "Docker Compose installed successfully"
}

# Install Git
install_git() {
    print_step "Installing Git"
    
    if [[ "$OSTYPE" == "linux-gnu"* ]]; then
        sudo apt-get update
        sudo apt-get install -y git
    elif [[ "$OSTYPE" == "darwin"* ]]; then
        # Check if Homebrew is installed
        if command -v brew &> /dev/null; then
            brew install git
        else
            print_info "Please install Git from https://git-scm.com/download/mac"
            exit 1
        fi
    fi
    
    print_success "Git installed successfully"
}

# Create project structure
create_project_structure() {
    print_step "Creating project structure"
    
    # Remove existing directory if it exists
    if [[ -d "$PROJECT_DIR" ]]; then
        print_warning "Project directory already exists. Backing up..."
        mv "$PROJECT_DIR" "${PROJECT_DIR}.backup.$(date +%Y%m%d_%H%M%S)"
    fi
    
    # Create main project directory
    mkdir -p "$PROJECT_DIR"
    cd "$PROJECT_DIR"
    
    # Create directory structure
    mkdir -p {services/{upload-service,approval-service,config-service,notification-service,auth-service},frontend,manager-frontend,admin-frontend,kratos,webdav-storage,sql,scripts,docs}
    
    # Create service subdirectories
    mkdir -p services/upload-service/{src,test}
    mkdir -p services/approval-service/src/main/{groovy,resources}
    mkdir -p services/config-service/{src,test}
    mkdir -p services/notification-service/{src,test}
    mkdir -p services/auth-service/{src,scripts}
    
    # Create frontend subdirectories
    mkdir -p frontend/{src,public}
    mkdir -p manager-frontend/{src,public}
    mkdir -p admin-frontend/{src,public}
    
    # Create configuration directories
    mkdir -p kratos/{config,schemas}
    mkdir -p {nginx,caddy,traefik}
    
    print_success "Project structure created"
}

# Generate Docker Compose files
generate_docker_compose() {
    print_step "Generating Docker Compose configuration"
    
    cat > docker-compose.yml << 'EOF'
version: '3.8'

services:
  # ============ REVERSE PROXY + AUTH LAYER ============
  caddy:
    image: caddy:2-alpine
    container_name: caddy-proxy
    environment:
      - FRONTEND_DOMAIN=${FRONTEND_DOMAIN:-upload.localhost}
      - API_DOMAIN=${API_DOMAIN:-api.localhost}
      - MANAGER_DOMAIN=${MANAGER_DOMAIN:-manager.localhost}
      - ADMIN_DOMAIN=${ADMIN_DOMAIN:-admin.localhost}
      - AUTH_DOMAIN=${AUTH_DOMAIN:-auth.localhost}
      - WEBDAV_DOMAIN=${WEBDAV_DOMAIN:-files.localhost}
    ports:
      - "${HTTP_PORT:-80}:80"
      - "${HTTPS_PORT:-443}:443"
    volumes:
      - ./Caddyfile:/etc/caddy/Caddyfile
      - caddy_data:/data
      - caddy_config:/config
    networks:
      - app_network
    depends_on:
      - auth-service
    restart: unless-stopped

  # ============ IDENTITY MANAGEMENT ============
  kratos:
    image: oryd/kratos:v1.0
    container_name: kratos-identity
    environment:
      - DSN=postgres://kratos:${KRATOS_DB_PASSWORD:-kratosSuperSecret}@postgres:5432/kratos
      - LOG_LEVEL=info
    volumes:
      - ./kratos:/etc/config/kratos
    networks:
      - app_network
    depends_on:
      - postgres
    restart: unless-stopped

  # ============ AUTH SERVICE (External) ============
  auth-service:
    build: ./services/auth-service
    container_name: auth-service
    environment:
      - NODE_ENV=${NODE_ENV:-development}
      - JWT_SECRET=${JWT_SECRET:-superSecretJwtKey}
      - KRATOS_PUBLIC_URL=http://kratos:4433
      - REDIS_URL=redis://redis:6379
    networks:
      - app_network
    depends_on:
      - kratos
      - redis
    restart: unless-stopped

  # ============ BUSINESS SERVICES (NO AUTH LOGIC!) ============
  upload-service:
    build: ./services/upload-service
    container_name: upload-service
    environment:
      - NODE_ENV=${NODE_ENV:-development}
      - WEBDAV_URL=http://webdav:80
      - APPROVAL_SERVICE_URL=http://approval-service:8080
      - DATABASE_URL=postgres://upload:${UPLOAD_DB_PASSWORD:-uploadSecret}@postgres:5432/uploaddb
    volumes:
      - upload_temp:/tmp/uploads
    networks:
      - app_network
    depends_on:
      - webdav
      - postgres
    restart: unless-stopped

  approval-service:
    build: ./services/approval-service
    container_name: approval-service
    environment:
      - SPRING_PROFILES_ACTIVE=${GROOVY_ENV:-development}
      - SPRING_DATASOURCE_URL=jdbc:postgresql://postgres:5432/uploaddb
      - SPRING_DATASOURCE_USERNAME=upload
      - SPRING_DATASOURCE_PASSWORD=${UPLOAD_DB_PASSWORD:-uploadSecret}
      - WEBDAV_URL=http://webdav:80
      - NOTIFICATION_SERVICE_URL=http://notification-service:3000
      - CONFIG_SERVICE_URL=http://config-service:8000
    networks:
      - app_network
    depends_on:
      - postgres
    restart: unless-stopped

  config-service:
    build: ./services/config-service
    container_name: config-service
    environment:
      - PYTHON_ENV=${PYTHON_ENV:-development}
      - DATABASE_URL=postgres://config:${CONFIG_DB_PASSWORD:-configSecret}@postgres:5432/config
    networks:
      - app_network
    depends_on:
      - postgres
    restart: unless-stopped

  notification-service:
    build: ./services/notification-service
    container_name: notification-service
    environment:
      - NODE_ENV=${NODE_ENV:-development}
      - CONFIG_SERVICE_URL=http://config-service:8000
    networks:
      - app_network
    restart: unless-stopped

  # ============ STORAGE & INFRASTRUCTURE ============
  webdav:
    image: hacdias/webdav:latest
    container_name: webdav-storage
    environment:
      - AUTH=false
    volumes:
      - webdav_data:/data
    networks:
      - app_network
    restart: unless-stopped

  postgres:
    image: postgres:15-alpine
    container_name: postgres-db
    environment:
      - POSTGRES_DB=uploaddb
      - POSTGRES_USER=postgres
      - POSTGRES_PASSWORD=${POSTGRES_PASSWORD:-postgresSecret}
    volumes:
      - postgres_data:/var/lib/postgresql/data
      - ./sql/init.sql:/docker-entrypoint-initdb.d/init.sql
    networks:
      - app_network
    restart: unless-stopped
    ports:
      - "5432:5432"

  redis:
    image: redis:7-alpine
    container_name: redis-cache
    networks:
      - app_network
    restart: unless-stopped

  # ============ FRONTENDS (NO AUTH LOGIC!) ============
  frontend:
    build: ./frontend
    container_name: public-frontend
    environment:
      - REACT_APP_API_URL=https://${API_DOMAIN:-api.localhost}
      - REACT_APP_UPLOAD_URL=https://${API_DOMAIN:-api.localhost}/uploads
    networks:
      - app_network
    restart: unless-stopped

  manager-frontend:
    build: ./manager-frontend
    container_name: manager-frontend
    environment:
      - REACT_APP_API_URL=https://${API_DOMAIN:-api.localhost}
      - REACT_APP_AUTH_URL=https://${AUTH_DOMAIN:-auth.localhost}
    networks:
      - app_network
    restart: unless-stopped

  admin-frontend:
    build: ./admin-frontend
    container_name: admin-frontend
    environment:
      - REACT_APP_API_URL=https://${API_DOMAIN:-api.localhost}
      - REACT_APP_AUTH_URL=https://${AUTH_DOMAIN:-auth.localhost}
    networks:
      - app_network
    restart: unless-stopped

networks:
  app_network:
    driver: bridge

volumes:
  caddy_data:
  caddy_config:
  postgres_data:
  webdav_data:
  upload_temp:
EOF

    print_success "Docker Compose configuration generated"
}

# Generate Caddyfile
generate_caddyfile() {
    print_step "Generating Caddyfile configuration"
    
    cat > Caddyfile << 'EOF'
# Ultimate Upload System - Caddyfile

# ============ PUBLIC UPLOAD (NO AUTH) ============
{$FRONTEND_DOMAIN:upload.localhost} {
    reverse_proxy frontend:3000
    
    # Enable large file uploads
    request_body {
        max_size 100MB
    }
}

# ============ API ENDPOINTS WITH SELECTIVE AUTH ============
{$API_DOMAIN:api.localhost} {
    # PUBLIC upload endpoint - no auth required
    route /uploads {
        reverse_proxy upload-service:3000
        request_body {
            max_size 100MB
        }
    }
    
    # PUBLIC file download - no auth required  
    route /files/* {
        reverse_proxy upload-service:3000
    }
    
    # MANAGER endpoints - require manager auth
    route /approval/* {
        forward_auth auth-service:3000 {
            uri /verify-manager
            copy_headers X-User-ID X-User-Email X-User-Roles X-Manager-ID
        }
        reverse_proxy approval-service:8080
    }
    
    # ADMIN config endpoints - require admin auth
    route /config/* {
        forward_auth auth-service:3000 {
            uri /verify-admin
            copy_headers X-User-ID X-User-Email X-User-Roles X-Admin-ID
        }
        reverse_proxy config-service:8000
    }
    
    # Internal notification service - no external access
    route /notifications/* {
        respond "Not Found" 404
    }
}

# ============ MANAGER DASHBOARD (AUTH REQUIRED) ============
{$MANAGER_DOMAIN:manager.localhost} {
    forward_auth auth-service:3000 {
        uri /verify-manager
        copy_headers X-User-ID X-User-Email X-User-Roles
    }
    reverse_proxy manager-frontend:3000
}

# ============ ADMIN PANEL (ADMIN AUTH REQUIRED) ============
{$ADMIN_DOMAIN:admin.localhost} {
    forward_auth auth-service:3000 {
        uri /verify-admin
        copy_headers X-User-ID X-User-Email X-User-Roles
    }
    reverse_proxy admin-frontend:3000
}

# ============ AUTH SERVICE ============
{$AUTH_DOMAIN:auth.localhost} {
    reverse_proxy auth-service:3000
}

# ============ WEBDAV STORAGE (PROTECTED) ============
{$WEBDAV_DOMAIN:files.localhost} {
    forward_auth auth-service:3000 {
        uri /verify-manager
        copy_headers X-User-ID X-User-Email X-User-Roles
    }
    reverse_proxy webdav:80
}
EOF

    print_success "Caddyfile generated"
}

# Generate environment files
generate_env_files() {
    print_step "Generating environment configuration"
    
    # Generate .env.example
    cat > .env.example << 'EOF'
# ============ ENVIRONMENT TYPE ============
ENVIRONMENT=development

# ============ DOMAINS (Change these for different environments) ============
FRONTEND_DOMAIN=upload.localhost
API_DOMAIN=api.localhost
MANAGER_DOMAIN=manager.localhost
ADMIN_DOMAIN=admin.localhost
AUTH_DOMAIN=auth.localhost
WEBDAV_DOMAIN=files.localhost

# ============ PORTS (Change for multi-server setups) ============
HTTP_PORT=80
HTTPS_PORT=443

# ============ APPLICATION ENVIRONMENT ============
NODE_ENV=development
PYTHON_ENV=development
GROOVY_ENV=development

# ============ SECURITY ============
JWT_SECRET=your-super-secret-jwt-key-change-in-production
POSTGRES_PASSWORD=postgresSecretPassword
KRATOS_DB_PASSWORD=kratosSuperSecretPassword
CONFIG_DB_PASSWORD=configSecretPassword
UPLOAD_DB_PASSWORD=uploadSecretPassword

# ============ PRODUCTION EXAMPLE ============
# FRONTEND_DOMAIN=upload.mycompany.com
# API_DOMAIN=api.mycompany.com
# MANAGER_DOMAIN=manager.mycompany.com
# ADMIN_DOMAIN=admin.mycompany.com
# AUTH_DOMAIN=auth.mycompany.com
# WEBDAV_DOMAIN=files.mycompany.com
# HTTP_PORT=80
# HTTPS_PORT=443
# NODE_ENV=production
# PYTHON_ENV=production
# GROOVY_ENV=production

# ============ VPS/SERVER EXAMPLE ============
# FRONTEND_DOMAIN=upload.yourdomain.com
# API_DOMAIN=api.yourdomain.com
# MANAGER_DOMAIN=manager.yourdomain.com
# ADMIN_DOMAIN=admin.yourdomain.com
# AUTH_DOMAIN=auth.yourdomain.com
# WEBDAV_DOMAIN=files.yourdomain.com

# ============ DEVELOPMENT WITH CUSTOM PORTS ============
# HTTP_PORT=8080
# HTTPS_PORT=8443
EOF

    # Generate actual .env based on environment
    if [[ "$ENVIRONMENT" == "local" ]]; then
        cat > .env << 'EOF'
ENVIRONMENT=development
FRONTEND_DOMAIN=upload.localhost
API_DOMAIN=api.localhost
MANAGER_DOMAIN=manager.localhost
ADMIN_DOMAIN=admin.localhost
AUTH_DOMAIN=auth.localhost
WEBDAV_DOMAIN=files.localhost
HTTP_PORT=80
HTTPS_PORT=443
NODE_ENV=development
PYTHON_ENV=development
GROOVY_ENV=development
JWT_SECRET=local-development-jwt-secret-key
POSTGRES_PASSWORD=devPostgresPassword
KRATOS_DB_PASSWORD=devKratosPassword
CONFIG_DB_PASSWORD=devConfigPassword
UPLOAD_DB_PASSWORD=devUploadPassword
EOF
    else
        # VPS configuration
        echo "Please configure your .env file for VPS deployment"
        cp .env.example .env
    fi
    
    print_success "Environment files generated"
}

# Generate database initialization
generate_database_init() {
    print_step "Generating database initialization"
    
    cat > sql/init.sql << 'EOF'
-- Ultimate Upload System Database Initialization

-- Create databases
CREATE DATABASE IF NOT EXISTS kratos;
CREATE DATABASE IF NOT EXISTS config;

-- Create users
CREATE USER IF NOT EXISTS kratos WITH PASSWORD 'kratosSuperSecret';
CREATE USER IF NOT EXISTS config WITH PASSWORD 'configSecret';
CREATE USER IF NOT EXISTS upload WITH PASSWORD 'uploadSecret';

-- Grant permissions
GRANT ALL PRIVILEGES ON DATABASE kratos TO kratos;
GRANT ALL PRIVILEGES ON DATABASE config TO config;
GRANT ALL PRIVILEGES ON DATABASE uploaddb TO upload;

-- Use uploaddb for application tables
\c uploaddb;

-- Uploads table
CREATE TABLE IF NOT EXISTS uploads (
    id SERIAL PRIMARY KEY,
    filename VARCHAR(255) NOT NULL,
    original_name VARCHAR(255) NOT NULL,
    mimetype VARCHAR(100),
    size BIGINT,
    description TEXT,
    uploader_email VARCHAR(255),
    status VARCHAR(50) DEFAULT 'pending',
    uploaded_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    approved_by VARCHAR(255),
    approved_at TIMESTAMP,
    rejection_reason TEXT
);

-- Approvals table
CREATE TABLE IF NOT EXISTS approvals (
    id SERIAL PRIMARY KEY,
    upload_id INTEGER REFERENCES uploads(id),
    manager_id VARCHAR(255),
    manager_email VARCHAR(255),
    action VARCHAR(50), -- 'approve' or 'reject'
    reason TEXT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Use config database for configuration
\c config;

-- Email configuration table
CREATE TABLE IF NOT EXISTS email_config (
    id SERIAL PRIMARY KEY,
    smtp_host VARCHAR(255),
    smtp_port INTEGER,
    smtp_username VARCHAR(255),
    smtp_password TEXT,
    from_email VARCHAR(255),
    from_name VARCHAR(255),
    updated_by VARCHAR(255),
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Insert default email configuration
INSERT INTO email_config (smtp_host, smtp_port, smtp_username, from_email, from_name, updated_by)
VALUES ('smtp.gmail.com', 587, 'noreply@company.com', 'noreply@company.com', 'Upload System', 'system')
ON CONFLICT DO NOTHING;
EOF

    print_success "Database initialization script generated"
}

# Generate all service files
generate_services() {
    print_step "Generating service implementations"
    
    # Upload Service
    generate_upload_service
    
    # Approval Service
    generate_approval_service
    
    # Config Service
    generate_config_service
    
    # Notification Service
    generate_notification_service
    
    # Auth Service
    generate_auth_service
    
    print_success "All services generated"
}

# Generate Upload Service
generate_upload_service() {
    # Package.json
    cat > services/upload-service/package.json << 'EOF'
{
  "name": "upload-service",
  "version": "1.0.0",
  "description": "File upload service with no auth logic",
  "main": "src/app.js",
  "scripts": {
    "start": "node src/app.js",
    "dev": "nodemon src/app.js",
    "test": "jest"
  },
  "dependencies": {
    "express": "^4.18.2",
    "multer": "^1.4.5-lts.1",
    "axios": "^1.6.0",
    "pg": "^8.11.3",
    "cors": "^2.8.5",
    "helmet": "^7.1.0"
  },
  "devDependencies": {
    "nodemon": "^3.0.1",
    "jest": "^29.7.0"
  }
}
EOF

    # Dockerfile
    cat > services/upload-service/Dockerfile << 'EOF'
FROM node:18-alpine

WORKDIR /app

# Copy package files
COPY package*.json ./

# Install dependencies
RUN npm ci --only=production

# Copy source code
COPY src/ ./src/

# Create upload directory
RUN mkdir -p /tmp/uploads

# Expose port
EXPOSE 3000

# Health check
HEALTHCHECK --interval=30s --timeout=3s --start-period=5s --retries=3 \
  CMD curl -f http://localhost:3000/health || exit 1

# Start application
CMD ["node", "src/app.js"]
EOF

    # Main application
    cat > services/upload-service/src/app.js << 'EOF'
const express = require('express');
const multer = require('multer');
const axios = require('axios');
const path = require('path');
const fs = require('fs').promises;
const { Pool } = require('pg');
const cors = require('cors');
const helmet = require('helmet');

const app = express();

// Security middleware
app.use(helmet());
app.use(cors());
app.use(express.json());

// Database connection
const pool = new Pool({
  connectionString: process.env.DATABASE_URL || 'postgres://upload:uploadSecret@localhost:5432/uploaddb'
});

// Multer config for file uploads
const upload = multer({
  dest: '/tmp/uploads/',
  limits: {
    fileSize: 100 * 1024 * 1024 // 100MB
  },
  fileFilter: (req, file, cb) => {
    // Add file type restrictions if needed
    cb(null, true);
  }
});

// Health check endpoint
app.get('/health', (req, res) => {
  res.json({ status: 'healthy', service: 'upload-service' });
});

// ============ PUBLIC UPLOAD ENDPOINT (NO AUTH) ============
app.post('/uploads', upload.single('file'), async (req, res) => {
  let client;
  
  try {
    if (!req.file) {
      return res.status(400).json({ error: 'No file uploaded' });
    }

    const { originalname, mimetype, size, path: tempPath } = req.file;
    const { description = '', uploaderEmail = '' } = req.body;

    // Generate unique filename
    const timestamp = Date.now();
    const filename = `${timestamp}_${originalname.replace(/[^a-zA-Z0-9.-]/g, '_')}`;
    
    // Start database transaction
    client = await pool.connect();
    await client.query('BEGIN');
    
    // Store metadata in database
    const insertQuery = `
      INSERT INTO uploads (filename, original_name, mimetype, size, description, uploader_email, status)
      VALUES ($1, $2, $3, $4, $5, $6, $7)
      RETURNING id
    `;
    
    const result = await client.query(insertQuery, [
      filename, originalname, mimetype, size, description, uploaderEmail, 'pending'
    ]);
    
    const uploadId = result.rows[0].id;

    // Move file to WebDAV storage
    await moveFileToWebDAV(tempPath, filename);

    // Commit transaction
    await client.query('COMMIT');

    // Notify approval service (internal call)
    setTimeout(() => {
      notifyApprovalService({
        id: uploadId,
        filename,
        originalName: originalname,
        uploaderEmail,
        description
      });
    }, 100);

    res.json({
      success: true,
      uploadId: uploadId,
      filename: filename,
      message: 'File uploaded successfully and pending approval'
    });

  } catch (error) {
    if (client) {
      await client.query('ROLLBACK');
    }
    console.error('Upload error:', error);
    
    // Clean up temp file
    if (req.file && req.file.path) {
      try {
        await fs.unlink(req.file.path);
      } catch (cleanupError) {
        console.error('Failed to cleanup temp file:', cleanupError);
      }
    }
    
    res.status(500).json({ error: 'Upload failed' });
  } finally {
    if (client) {
      client.release();
    }
  }
});

// ============ PUBLIC FILE ACCESS (NO AUTH) ============
app.get('/files/:filename', async (req, res) => {
  try {
    const { filename } = req.params;
    
    // Check if file is approved (business logic only)
    const query = 'SELECT * FROM uploads WHERE filename = $1 AND status = $2';
    const result = await pool.query(query, [filename, 'approved']);
    
    if (result.rows.length === 0) {
      return res.status(404).json({ error: 'File not found or not approved' });
    }
    
    const uploadRecord = result.rows[0];

    // Proxy to WebDAV
    const webdavUrl = `${process.env.WEBDAV_URL}/${filename}`;
    const response = await axios.get(webdavUrl, { responseType: 'stream' });
    
    res.set({
      'Content-Type': uploadRecord.mimetype,
      'Content-Disposition': `attachment; filename="${uploadRecord.original_name}"`
    });
    
    response.data.pipe(res);

      } catch (error) {
    console.error('Failed to send rejection notification:', error);
    res.status(500).json({ 
      success: false, 
      error: 'Failed to send notification' 
    });
  }
});

// ============ BUSINESS LOGIC FUNCTIONS (NO AUTH) ============
async function getEmailConfig() {
  try {
    // Internal call to config service - no auth needed
    const response = await axios.get(`${process.env.CONFIG_SERVICE_URL}/config/email/internal`);
    return response.data;
  } catch (error) {
    console.error('Failed to get email config:', error);
    throw new Error('Email configuration not available');
  }
}

async function sendEmail(config, { to, subject, html }) {
  // Create transporter with config from admin settings
  const transporter = nodemailer.createTransporter({
    host: config.smtp_host,
    port: config.smtp_port,
    secure: config.smtp_port === 465,
    auth: {
      user: config.smtp_username,
      pass: config.smtp_password
    }
  });

  // Send email
  const mailOptions = {
    from: `"${config.from_name}" <${config.from_email}>`,
    to: to,
    subject: subject,
    html: html
  };

  await transporter.sendMail(mailOptions);
  console.log(`Email sent successfully to ${to}`);
}

// Error handling
app.use((error, req, res, next) => {
  console.error('Unhandled error:', error);
  res.status(500).json({ error: 'Internal server error' });
});

const PORT = process.env.PORT || 3000;
app.listen(PORT, () => {
  console.log(`Notification Service running on port ${PORT} (NO AUTH LOGIC!)`);
});
EOF

    # Dockerfile
    cat > services/notification-service/Dockerfile << 'EOF'
FROM node:18-alpine

WORKDIR /app

# Copy package files
COPY package*.json ./

# Install dependencies
RUN npm ci --only=production

# Copy source code
COPY src/ ./src/

# Expose port
EXPOSE 3000

# Health check
HEALTHCHECK --interval=30s --timeout=3s --start-period=5s --retries=3 \
  CMD curl -f http://localhost:3000/health || exit 1

# Start application
CMD ["node", "src/app.js"]
EOF
}

# Generate Auth Service
generate_auth_service() {
    # Package.json
    cat > services/auth-service/package.json << 'EOF'
{
  "name": "auth-service",
  "version": "1.0.0",
  "description": "External authentication service",
  "main": "src/app.js",
  "scripts": {
    "start": "node src/app.js",
    "dev": "nodemon src/app.js",
    "test": "jest",
    "create-admin": "node scripts/create-admin.js"
  },
  "dependencies": {
    "express": "^4.18.2",
    "jsonwebtoken": "^9.0.2",
    "bcrypt": "^5.1.1",
    "axios": "^1.6.0",
    "redis": "^4.6.10",
    "cors": "^2.8.5",
    "helmet": "^7.1.0",
    "cookie-parser": "^1.4.6"
  },
  "devDependencies": {
    "nodemon": "^3.0.1",
    "jest": "^29.7.0"
  }
}
EOF

    # Main application
    cat > services/auth-service/src/app.js << 'EOF'
const express = require('express');
const jwt = require('jsonwebtoken');
const bcrypt = require('bcrypt');
const axios = require('axios');
const Redis = require('redis');
const cors = require('cors');
const helmet = require('helmet');
const cookieParser = require('cookie-parser');

const app = express();

// Security middleware
app.use(helmet());
app.use(cors({
  origin: true,
  credentials: true
}));
app.use(express.json());
app.use(cookieParser());

// Redis connection
const redis = Redis.createClient({ 
  url: process.env.REDIS_URL || 'redis://localhost:6379' 
});

redis.connect().catch(console.error);

// Health check endpoint
app.get('/health', (req, res) => {
  res.json({ status: 'healthy', service: 'auth-service' });
});

// ============ AUTH VERIFICATION ENDPOINTS (FOR CADDY) ============
app.get('/verify-manager', async (req, res) => {
  try {
    const authHeader = req.headers.authorization;
    const sessionCookie = req.headers.cookie;
    
    let user;
    
    // Try JWT first, then session cookie
    if (authHeader && authHeader.startsWith('Bearer ')) {
      user = await verifyJWT(authHeader.replace('Bearer ', ''));
    } else if (sessionCookie) {
      user = await verifySession(sessionCookie);
    } else {
      return res.status(401).json({ error: 'No authentication provided' });
    }
    
    // Check if user has manager role
    if (!user.roles.includes('manager') && !user.roles.includes('admin')) {
      return res.status(403).json({ error: 'Manager access required' });
    }
    
    // Return headers for Caddy to forward
    res.set({
      'X-User-ID': user.id,
      'X-User-Email': user.email,
      'X-User-Roles': JSON.stringify(user.roles),
      'X-Manager-ID': user.id
    });
    
    res.json({ success: true, user: user.email });
    
  } catch (error) {
    console.error('Manager verification failed:', error);
    res.status(401).json({ error: 'Authentication failed' });
  }
});

app.get('/verify-admin', async (req, res) => {
  try {
    const authHeader = req.headers.authorization;
    const sessionCookie = req.headers.cookie;
    
    let user;
    
    if (authHeader && authHeader.startsWith('Bearer ')) {
      user = await verifyJWT(authHeader.replace('Bearer ', ''));
    } else if (sessionCookie) {
      user = await verifySession(sessionCookie);
    } else {
      return res.status(401).json({ error: 'No authentication provided' });
    }
    
    // Check if user has admin role
    if (!user.roles.includes('admin')) {
      return res.status(403).json({ error: 'Admin access required' });
    }
    
    // Return headers for Caddy
    res.set({
      'X-User-ID': user.id,
      'X-User-Email': user.email,
      'X-User-Roles': JSON.stringify(user.roles),
      'X-Admin-ID': user.id
    });
    
    res.json({ success: true, user: user.email });
    
  } catch (error) {
    console.error('Admin verification failed:', error);
    res.status(401).json({ error: 'Authentication failed' });
  }
});

// ============ LOGIN ENDPOINTS ============
app.post('/login', async (req, res) => {
  try {
    const { email, password } = req.body;
    
    if (!email || !password) {
      return res.status(400).json({ error: 'Email and password required' });
    }
    
    // Verify credentials
    const user = await authenticateUser(email, password);
    if (!user) {
      return res.status(401).json({ error: 'Invalid credentials' });
    }
    
    // Generate JWT
    const token = jwt.sign(
      { 
        sub: user.id,
        email: user.email,
        roles: user.roles
      },
      process.env.JWT_SECRET || 'default-secret',
      { expiresIn: '24h' }
    );
    
    // Store session in Redis
    const sessionId = `session:${user.id}:${Date.now()}`;
    await redis.setEx(sessionId, 86400, JSON.stringify(user)); // 24h expiry
    
    // Set session cookie
    res.cookie('sessionId', sessionId, {
      httpOnly: true,
      secure: process.env.NODE_ENV === 'production',
      maxAge: 86400000 // 24h
    });
    
    res.json({
      success: true,
      token,
      user: {
        id: user.id,
        email: user.email,
        roles: user.roles
      }
    });
    
  } catch (error) {
    console.error('Login failed:', error);
    res.status(500).json({ error: 'Login failed' });
  }
});

app.post('/logout', async (req, res) => {
  try {
    const sessionCookie = req.headers.cookie;
    if (sessionCookie) {
      const sessionId = extractSessionId(sessionCookie);
      if (sessionId) {
        await redis.del(sessionId);
      }
    }
    
    // Clear session cookie
    res.clearCookie('sessionId');
    
    res.json({ success: true, message: 'Logged out successfully' });
  } catch (error) {
    res.status(500).json({ error: 'Logout failed' });
  }
});

// ============ USER MANAGEMENT ENDPOINTS ============
app.post('/create-user', async (req, res) => {
  try {
    const { email, password, roles = ['user'] } = req.body;
    
    if (!email || !password) {
      return res.status(400).json({ error: 'Email and password required' });
    }
    
    // Check if user already exists
    const existingUser = await getUserByEmail(email);
    if (existingUser) {
      return res.status(409).json({ error: 'User already exists' });
    }
    
    // Hash password
    const hashedPassword = await bcrypt.hash(password, 10);
    
    // Create user (in real app, save to database)
    const user = {
      id: `user-${Date.now()}`,
      email,
      password: hashedPassword,
      roles,
      created_at: new Date()
    };
    
    // Store in Redis (temporary - use real database in production)
    await redis.setEx(`user:${email}`, 86400 * 365, JSON.stringify(user));
    
    res.json({
      success: true,
      message: 'User created successfully',
      user: {
        id: user.id,
        email: user.email,
        roles: user.roles
      }
    });
    
  } catch (error) {
    console.error('Failed to create user:', error);
    res.status(500).json({ error: 'Failed to create user' });
  }
});

// ============ AUTH HELPER FUNCTIONS ============
async function verifyJWT(token) {
  const payload = jwt.verify(token, process.env.JWT_SECRET || 'default-secret');
  return {
    id: payload.sub,
    email: payload.email,
    roles: payload.roles
  };
}

async function verifySession(cookieHeader) {
  const sessionId = extractSessionId(cookieHeader);
  if (!sessionId) {
    throw new Error('No session ID found');
  }
  
  const sessionData = await redis.get(sessionId);
  
  if (!sessionData) {
    throw new Error('Session not found');
  }
  
  return JSON.parse(sessionData);
}

function extractSessionId(cookieHeader) {
  const match = cookieHeader.match(/sessionId=([^;]+)/);
  return match ? match[1] : null;
}

async function authenticateUser(email, password) {
  try {
    // Get user from storage
    const user = await getUserByEmail(email);
    if (!user) return null;
    
    // Verify password
    const isValid = await bcrypt.compare(password, user.password);
    if (!isValid) return null;
    
    return {
      id: user.id,
      email: user.email,
      roles: user.roles
    };
  } catch (error) {
    console.error('Authentication error:', error);
    return null;
  }
}

async function getUserByEmail(email) {
  try {
    const userData = await redis.get(`user:${email}`);
    return userData ? JSON.parse(userData) : null;
  } catch (error) {
    console.error('Failed to get user:', error);
    return null;
  }
}

// Error handling
app.use((error, req, res, next) => {
  console.error('Unhandled error:', error);
  res.status(500).json({ error: 'Internal server error' });
});

const PORT = process.env.PORT || 3000;
app.listen(PORT, () => {
  console.log(`Auth Service running on port ${PORT}`);
});
EOF

    # Create admin script
    cat > services/auth-service/scripts/create-admin.js << 'EOF'
const bcrypt = require('bcrypt');
const Redis = require('redis');

async function createAdmin() {
  const redis = Redis.createClient({ 
    url: process.env.REDIS_URL || 'redis://localhost:6379' 
  });
  
  try {
    await redis.connect();
    
    // Create admin user
    const adminUser = {
      id: 'admin-001',
      email: 'admin@company.com',
      password: await bcrypt.hash('admin123', 10),
      roles: ['admin', 'manager'],
      created_at: new Date()
    };
    
    // Create manager user
    const managerUser = {
      id: 'mgr-001',
      email: 'manager@company.com',
      password: await bcrypt.hash('manager123', 10),
      roles: ['manager'],
      created_at: new Date()
    };
    
    // Store users
    await redis.setEx(`user:${adminUser.email}`, 86400 * 365, JSON.stringify(adminUser));
    await redis.setEx(`user:${managerUser.email}`, 86400 * 365, JSON.stringify(managerUser));
    
    console.log('✅ Admin and Manager users created successfully!');
    console.log('Admin: admin@company.com / admin123');
    console.log('Manager: manager@company.com / manager123');
    
  } catch (error) {
    console.error('❌ Failed to create users:', error);
  } finally {
    await redis.disconnect();
  }
}

createAdmin();
EOF

    # Dockerfile
    cat > services/auth-service/Dockerfile << 'EOF'
FROM node:18-alpine

WORKDIR /app

# Copy package files
COPY package*.json ./

# Install dependencies
RUN npm ci --only=production

# Copy source code
COPY src/ ./src/
COPY scripts/ ./scripts/

# Expose port
EXPOSE 3000

# Health check
HEALTHCHECK --interval=30s --timeout=3s --start-period=5s --retries=3 \
  CMD curl -f http://localhost:3000/health || exit 1

# Start application
CMD ["node", "src/app.js"]
EOF
}

# Generate frontend applications
generate_frontends() {
    print_step "Generating frontend applications"
    
    # Public Upload Frontend
    generate_public_frontend
    
    # Manager Frontend
    generate_manager_frontend
    
    # Admin Frontend
    generate_admin_frontend
    
    print_success "Frontend applications generated"
}

# Generate Public Frontend
generate_public_frontend() {
    # Package.json
    cat > frontend/package.json << 'EOF'
{
  "name": "upload-frontend",
  "version": "1.0.0",
  "private": true,
  "dependencies": {
    "react": "^18.2.0",
    "react-dom": "^18.2.0",
    "react-scripts": "5.0.1",
    "axios": "^1.6.0",
    "web-vitals": "^3.5.0"
  },
  "scripts": {
    "start": "react-scripts start",
    "build": "react-scripts build",
    "test": "react-scripts test",
    "eject": "react-scripts eject"
  },
  "eslintConfig": {
    "extends": [
      "react-app",
      "react-app/jest"
    ]
  },
  "browserslist": {
    "production": [
      ">0.2%",
      "not dead",
      "not op_mini all"
    ],
    "development": [
      "last 1 chrome version",
      "last 1 firefox version",
      "last 1 safari version"
    ]
  }
}
EOF

    # Main App component
    cat > frontend/src/App.js << 'EOF'
import React, { useState } from 'react';
import axios from 'axios';
import './App.css';

const API_URL = process.env.REACT_APP_API_URL || 'http://api.localhost';

function App() {
  const [file, setFile] = useState(null);
  const [description, setDescription] = useState('');
  const [uploaderEmail, setUploaderEmail] = useState('');
  const [uploading, setUploading] = useState(false);
  const [result, setResult] = useState(null);
  const [dragActive, setDragActive] = useState(false);

  const handleFileChange = (e) => {
    setFile(e.target.files[0]);
  };

  const handleDrag = (e) => {
    e.preventDefault();
    e.stopPropagation();
    if (e.type === "dragenter" || e.type === "dragover") {
      setDragActive(true);
    } else if (e.type === "dragleave") {
      setDragActive(false);
    }
  };

  const handleDrop = (e) => {
    e.preventDefault();
    e.stopPropagation();
    setDragActive(false);
    
    if (e.dataTransfer.files && e.dataTransfer.files[0]) {
      setFile(e.dataTransfer.files[0]);
    }
  };

  const handleSubmit = async (e) => {
    e.preventDefault();
    
    if (!file) {
      alert('Please select a file');
      return;
    }
    
    if (!uploaderEmail) {
      alert('Please provide your email address');
      return;
    }
    
    setUploading(true);
    setResult(null);
    
    try {
      const formData = new FormData();
      formData.append('file', file);
      formData.append('description', description);
      formData.append('uploaderEmail', uploaderEmail);
      
      // NO AUTH NEEDED - public endpoint
      const response = await axios.post(`${API_URL}/uploads`, formData, {
        headers: {
          'Content-Type': 'multipart/form-data'
        },
        onUploadProgress: (progressEvent) => {
          const percentCompleted = Math.round((progressEvent.loaded * 100) / progressEvent.total);
          console.log(`Upload Progress: ${percentCompleted}%`);
        }
      });
      
      setResult({
        success: true,
        message: response.data.message,
        uploadId: response.data.uploadId
      });
      
      // Reset form
      setFile(null);
      setDescription('');
      setUploaderEmail('');
      
    } catch (error) {
      setResult({
        success: false,
        message: error.response?.data?.error || 'Upload failed'
      });
    } finally {
      setUploading(false);
    }
  };

  const formatFileSize = (bytes) => {
    if (bytes === 0) return '0 Bytes';
    const k = 1024;
    const sizes = ['Bytes', 'KB', 'MB', 'GB'];
    const i = Math.floor(Math.log(bytes) / Math.log(k));
    return parseFloat((bytes / Math.pow(k, i)).toFixed(2)) + ' ' + sizes[i];
  };

  return (
    <div className="App">
      <div className="container">
        <header className="app-header">
          <h1>🚀 Ultimate Upload System</h1>
          <p>Upload your files for approval. No account required!</p>
        </header>
        
        <main className="upload-main">
          <form onSubmit={handleSubmit} className="upload-form">
            <div className="form-group">
              <label htmlFor="email">Your Email Address *</label>
              <input
                type="email"
                id="email"
                value={uploaderEmail}
                onChange={(e) => setUploaderEmail(e.target.value)}
                placeholder="We'll notify you when your file is approved"
                required
                className="form-input"
              />
              <small>We'll send you a notification when your file is reviewed</small>
            </div>
            
            <div className="form-group">
              <label htmlFor="file">Select File *</label>
              <div 
                className={`file-drop-zone ${dragActive ? 'active' : ''} ${file ? 'has-file' : ''}`}
                onDragEnter={handleDrag}
                onDragLeave={handleDrag}
                onDragOver={handleDrag}
                onDrop={handleDrop}
              >
                <input
                  type="file"
                  id="file"
                  onChange={handleFileChange}
                  required
                  className="file-input"
                />
                {file ? (
                  <div className="file-info">
                    <span className="file-icon">📄</span>
                    <div>
                      <div className="file-name">{file.name}</div>
                      <div className="file-size">{formatFileSize(file.size)}</div>
                    </div>
                  </div>
                ) : (
                  <div className="file-drop-content">
                    <span className="file-icon">📁</span>
                    <p>Drag and drop your file here, or click to select</p>
                    <small>Maximum file size: 100MB</small>
                  </div>
                )}
              </div>
            </div>
            
            <div className="form-group">
              <label htmlFor="description">Description (optional)</label>
              <textarea
                id="description"
                value={description}
                onChange={(e) => setDescription(e.target.value)}
                placeholder="Brief description of the file (optional)"
                className="form-textarea"
                rows="3"
              />
            </div>
            
            <button 
              type="submit" 
              disabled={uploading}
              className={`submit-btn ${uploading ? 'uploading' : ''}`}
            >
              {uploading ? (
                <>
                  <span className="spinner"></span>
                  Uploading...
                </>
              ) : (
                'Upload File'
              )}
            </button>
          </form>
          
          {result && (
            <div className={`result ${result.success ? 'success' : 'error'}`}>
              <div className="result-icon">
                {result.success ? '✅' : '❌'}
              </div>
              <div className="result-content">
                <p>{result.message}</p>
                {result.success && (
                  <div className="upload-details">
                    <p><strong>Upload ID:</strong> {result.uploadId}</p>
                    <p><small>Save this ID for your records. You'll receive an email notification when your file is reviewed.</small></p>
                  </div>
                )}
              </div>
            </div>
          )}
        </main>
        
        <footer className="app-footer">
          <p>Powered by Ultimate Upload System - Infrastructure Separation Architecture</p>
        </footer>
      </div>
    </div>
  );
}

export default App;
EOF

    # CSS styles
    cat > frontend/src/App.css << 'EOF'
* {
  margin: 0;
  padding: 0;
  box-sizing: border-box;
}

body {
  font-family: -apple-system, BlinkMacSystemFont, 'Segoe UI', 'Roboto', 'Oxygen',
    'Ubuntu', 'Cantarell', 'Fira Sans', 'Droid Sans', 'Helvetica Neue',
    sans-serif;
  -webkit-font-smoothing: antialiased;
  -moz-osx-font-smoothing: grayscale;
  background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
  min-height: 100vh;
}

.App {
  min-height: 100vh;
  display: flex;
  align-items: center;
  justify-content: center;
  padding: 20px;
}

.container {
  background: white;
  border-radius: 12px;
  box-shadow: 0 10px 30px rgba(0, 0, 0, 0.1);
  padding: 40px;
  max-width: 600px;
  width: 100%;
}

.app-header {
  text-align: center;
  margin-bottom: 40px;
}

.app-header h1 {
  color: #333;
  margin-bottom: 10px;
  font-size: 2.5rem;
}

.app-header p {
  color: #666;
  font-size: 1.1rem;
}

.upload-form {
  display: flex;
  flex-direction: column;
  gap: 24px;
}

.form-group {
  display: flex;
  flex-direction: column;
  gap: 8px;
}

.form-group label {
  font-weight: 600;
  color: #333;
  font-size: 0.95rem;
}

.form-input,
.form-textarea {
  padding: 12px 16px;
  border: 2px solid #e0e0e0;
  border-radius: 8px;
  font-size: 1rem;
  transition: border-color 0.3s ease;
}

.form-input:focus,
.form-textarea:focus {
  outline: none;
  border-color: #667eea;
}

.form-group small {
  color: #666;
  font-size: 0.85rem;
}

.file-drop-zone {
  border: 2px dashed #e0e0e0;
  border-radius: 8px;
  padding: 40px 20px;
  text-align: center;
  cursor: pointer;
  transition: all 0.3s ease;
  position: relative;
}

.file-drop-zone:hover,
.file-drop-zone.active {
  border-color: #667eea;
  background-color: #f8f9ff;
}

.file-drop-zone.has-file {
  border-color: #28a745;
  background-color: #f8fff9;
}

.file-input {
  position: absolute;
  inset: 0;
  opacity: 0;
  cursor: pointer;
}

.file-drop-content {
  display: flex;
  flex-direction: column;
  align-items: center;
  gap: 12px;
}

.file-icon {
  font-size: 3rem;
  margin-bottom: 8px;
}

.file-info {
  display: flex;
  align-items: center;
  gap: 16px;
}

.file-name {
  font-weight: 600;
  color: #333;
}

.file-size {
  color: #666;
  font-size: 0.9rem;
}

.submit-btn {
  background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
  color: white;
  border: none;
  padding: 16px 24px;
  border-radius: 8px;
  font-size: 1.1rem;
  font-weight: 600;
  cursor: pointer;
  transition: all 0.3s ease;
  display: flex;
  align-items: center;
  justify-content: center;
  gap: 8px;
}

.submit-btn:hover:not(:disabled) {
  transform: translateY(-2px);
  box-shadow: 0 5px 15px rgba(102, 126, 234, 0.4);
}

.submit-btn:disabled {
  opacity: 0.7;
  cursor: not-allowed;
  transform: none;
}

.spinner {
  width: 20px;
  height: 20px;
  border: 2px solid #ffffff;
  border-top: 2px solid transparent;
  border-radius: 50%;
  animation: spin 1s linear infinite;
}

@keyframes spin {
  0% { transform: rotate(0deg); }
  100% { transform: rotate(360deg); }
}

.result {
  margin-top: 24px;
  padding: 20px;
  border-radius: 8px;
  display: flex;
  align-items: flex-start;
  gap: 16px;
}

.result.success {
  background-color: #d4edda;
  border: 1px solid #c3e6cb;
  color: #155724;
}

.result.error {
  background-color: #f8d7da;
  border: 1px solid #f5c6cb;
  color: #721c24;
}

.result-icon {
  font-size: 1.5rem;
  flex-shrink: 0;
}

.result-content {
  flex-grow: 1;
}

.upload-details {
  margin-top: 12px;
  padding-top: 12px;
  border-top: 1px solid rgba(0, 0, 0, 0.1);
}

.upload-details p {
  margin-bottom: 4px;
}

.app-footer {
  text-align: center;
  margin-top: 40px;
  padding-top: 20px;
  border-top: 1px solid #e0e0e0;
  color: #666;
  font-size: 0.9rem;
}

@media (max-width: 768px) {
  .container {
    margin: 10px;
    padding: 24px;
  }
  
  .app-header h1 {
    font-size: 2rem;
  }
  
  .file-drop-zone {
    padding: 24px 16px;
  }
}
EOF

    # Index.js
    cat > frontend/src/index.js << 'EOF'
import React from 'react';
import ReactDOM from 'react-dom/client';
import App from './App';

const root = ReactDOM.createRoot(document.getElementById('root'));
root.render(
  <React.StrictMode>
    <App />
  </React.StrictMode>
);
EOF

    # Public HTML
    cat > frontend/public/index.html << 'EOF'
<!DOCTYPE html>
<html langerror('Download error:', error);
    res.status(404).json({ error: 'File not found' });
  }
});

// ============ BUSINESS LOGIC FUNCTIONS (NO AUTH) ============
async function moveFileToWebDAV(tempPath, filename) {
  try {
    const fileBuffer = await fs.readFile(tempPath);
    const webdavUrl = `${process.env.WEBDAV_URL}/${filename}`;
    
    await axios.put(webdavUrl, fileBuffer, {
      headers: { 'Content-Type': 'application/octet-stream' },
      maxBodyLength: Infinity,
      maxContentLength: Infinity
    });
    
    // Clean up temp file
    await fs.unlink(tempPath);
    
    console.log(`File moved to WebDAV: ${filename}`);
  } catch (error) {
    console.error('Failed to move file to WebDAV:', error);
    throw error;
  }
}

async function notifyApprovalService(uploadRecord) {
  try {
    await axios.post(`${process.env.APPROVAL_SERVICE_URL}/process-upload`, uploadRecord, {
      timeout: 5000
    });
    console.log(`Notified approval service for upload: ${uploadRecord.id}`);
  } catch (error) {
    console.error('Failed to notify approval service:', error);
    // Don't throw - this is non-critical
  }
}

// Error handling
app.use((error, req, res, next) => {
  console.error('Unhandled error:', error);
  res.status(500).json({ error: 'Internal server onChange={(e) => handleInputChange('from_name', e.target.value)}
                  placeholder="Upload System"
                  required
                  className="form-input"
                />
                <small>Display name that appears as sender</small>
              </div>
            </div>

            <div className="form-actions">
              <button
                type="submit"
                disabled={saving}
                className="save-btn"
              >
                {saving ? (
                  <>
                    <span className="spinner-small"></span>
                    Saving...
                  </>
                ) : (
                  'Save Configuration'
                )}
              </button>

              <button
                type="button"
                onClick={testEmailConfig}
                disabled={testing}
                className="test-btn"
              >
                {testing ? (
                  <>
                    <span className="spinner-small"></span>
                    Testing...
                  </>
                ) : (
                  '📤 Test Email'
                )}
              </button>
            </div>
          </form>

          {testResult && (
            <div className={`test-result ${testResult.success ? 'success' : 'error'}`}>
              <div className="result-icon">
                {testResult.success ? '✅' : '❌'}
              </div>
              <div className="result-message">
                {testResult.message}
              </div>
            </div>
          )}

          {user.updatedBy && (
            <div className="config-info">
              <p><strong>Last updated by:</strong> {user.updatedBy}</p>
              {user.updatedAt && (
                <p><strong>Last updated:</strong> {new Date(user.updatedAt).toLocaleString()}</p>
              )}
            </div>
          )}
        </div>

        <div className="help-section">
          <h3>📚 Configuration Help</h3>
          <div className="help-content">
            <div className="help-item">
              <h4>Gmail SMTP Settings</h4>
              <ul>
                <li>SMTP Host: smtp.gmail.com</li>
                <li>SMTP Port: 587</li>
                <li>Username: Your Gmail address</li>
                <li>Password: App-specific password (not your regular Gmail password)</li>
              </ul>
            </div>

            <div className="help-item">
              <h4>Outlook/Hotmail SMTP Settings</h4>
              <ul>
                <li>SMTP Host: smtp-mail.outlook.com</li>
                <li>SMTP Port: 587</li>
                <li>Username: Your Outlook/Hotmail address</li>
                <li>Password: Your account password</li>
              </ul>
            </div>

            <div className="help-item">
              <h4>Security Notes</h4>
              <ul>
                <li>Always use app-specific passwords when available</li>
                <li>Enable 2FA on your email account</li>
                <li>Test the configuration after making changes</li>
                <li>Monitor email delivery logs</li>
              </ul>
            </div>
          </div>
        </div>
      </main>

      <footer className="admin-footer">
        <p>Ultimate Upload System - Admin Panel</p>
      </footer>
    </div>
  );
}

export default App;
EOF