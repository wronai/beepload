# 🐝 Beepload - Ultimate Upload System

A comprehensive file upload system with approval workflow, user management, and secure file storage, featuring complete separation of authentication from business logic.

## 🌟 Features

- 🚀 **Drag & Drop** file uploads with progress tracking
- 🔒 **Role-Based Access Control** (User, Manager, Admin)
- 📧 **Email Notifications** for uploads and approvals
- 🔄 **Approval Workflow** with manager review
- 📦 **WebDAV Storage** with web interface
- 🔐 **Ory Kratos** for authentication
- 🛡️ **Caddy** as reverse proxy with automatic HTTPS
- 🐳 **Docker Compose** for easy deployment

## 🏗️ System Architecture

```
┌──────────────────────────────────────────────────────────────────────┐
│                            Browser (HTTPS)                           │
└───────────────────────────────┬──────────────────────────────────────┘
                                │
                    ┌───────────▼───────────┐
                    │       Caddy v2         │  ← Authentication & TLS
                    │  (Reverse Proxy)       │  ← Static file serving
                    └───────────┬───────────┘
                                │
        ┌───────────────────────┴───────────────────────┐
        │                                               │
┌───────▼───────┐                              ┌────────▼────────┐
│  Auth Service │                              │  WebDAV Storage │
│  (Kratos)     │                              │  (Read-Only)    │
└───────┬───────┘                              └────────┬────────┘
        │                                               │
        │                                               │
┌───────▼───────────────────────────────┐      ┌────────▼────────┐
│         Business Services             │      │  File Storage   │
│  ┌─────────────┐     ┌─────────────┐  │      │  (WebDAV)       │
│  │  Upload     │     │  Approval   │  │      └─────────────────┘
│  │  Service    ├─────►  Service    │  │
│  └─────────────┘     └──────┬──────┘  │
│         ▲                   │         │
│         │                   │         │
│  ┌──────┴───────┐    ┌──────▼──────┐  │
│  │  Config      │    │ Notification│  │
│  │  Service     │    │ Service     │  │
│  └──────────────┘    └─────────────┘  │
└───────────────────────────────────────┘
```

## 🚀 Getting Started

### Prerequisites

- Docker and Docker Compose
- Node.js 18+ (for development)
- Git

### Quick Start

1. **Clone the repository**
   ```bash
   git clone https://github.com/wronai/beepload.git
   cd beepload
   ```

2. **Set up environment**
   ```bash
   cp .env.example .env
   # Edit .env with your configuration
   ```

3. **Start the services**
   ```bash
   docker-compose up -d
   ```

4. **Access the applications**
   - Public Upload: http://upload.localhost
   - Manager Dashboard: http://manager.localhost
   - Admin Panel: http://admin.localhost
   - WebDAV Files: http://files.localhost (requires manager login)
   - Auth Service: http://auth.localhost

## 🔧 Configuration

### Environment Variables

Edit the `.env` file to configure the system:

```bash
# ============ DOMAINS ============
FRONTEND_DOMAIN=upload.localhost
API_DOMAIN=api.localhost
MANAGER_DOMAIN=manager.localhost
ADMIN_DOMAIN=admin.localhost
AUTH_DOMAIN=auth.localhost
WEBDAV_DOMAIN=files.localhost

# ============ PORTS ============
HTTP_PORT=80
HTTPS_PORT=443

# ============ SECURITY ============
JWT_SECRET=your-super-secret-jwt-key
POSTGRES_PASSWORD=postgresSecretPassword
KRATOS_DB_PASSWORD=kratosSuperSecretPassword
CONFIG_DB_PASSWORD=configSecretPassword

# ============ EMAIL ============
SMTP_HOST=smtp.example.com
SMTP_PORT=587
SMTP_USER=user@example.com
SMTP_PASSWORD=your-smtp-password
SMTP_FROM=noreply@example.com
```

### Production Deployment

For production, make sure to:
1. Set proper domain names in `.env`
2. Generate strong passwords
3. Configure SMTP for email notifications
4. Set `NODE_ENV=production`
5. Use proper SSL certificates (auto-configured by Caddy)

## 🛠️ Development

### Project Structure

```
beepload/
├── docker-compose.yml       # Main Docker Compose configuration
├── Caddyfile               # Reverse proxy configuration
├── .env.example            # Environment variables template
├── kratos/                 # Ory Kratos configuration
├── services/               # Backend services
│   ├── upload-service/     # File upload service (Node.js)
│   ├── approval-service/   # Approval workflow (Groovy)
│   ├── config-service/     # Configuration service (Python)
│   └── notification-service/ # Email notifications (Node.js)
├── frontend/              # Public upload interface
├── manager-frontend/       # Manager dashboard
├── admin-frontend/         # Admin configuration panel
└── webdav-storage/         # File storage
```

### Building Services

Each service has its own `Dockerfile` and can be built separately:

```bash
docker-compose build <service-name>
# Example:
docker-compose build upload-service
```

Or build all services:

```bash
docker-compose build
```

## 🔒 Authentication & Authorization

The system uses Ory Kratos for authentication with the following roles:

1. **Public Users**
   - Can upload files
   - Receive email notifications

2. **Managers**
   - Can approve/reject uploads
   - Access WebDAV storage
   - View all uploads

3. **Admins**
   - Full system access
   - Configure system settings
   - Manage users and roles

## 📁 File Storage

Files are stored using WebDAV with the following structure:

```
webdav-storage/
├── uploads/          # Temporary uploads
├── approved/         # Approved files
└── rejected/         # Rejected files
```

## 📧 Email Notifications

The system sends emails for:
- New file uploads (to managers)
- Approval/rejection (to uploaders)
- System notifications (to admins)

## 🔍 API Documentation

API documentation is available at `http://api.localhost/docs` when the services are running.

## 🚨 Troubleshooting

### Common Issues

1. **Caddy not starting**
   - Check `docker-compose logs caddy` for errors
   - Verify the Caddyfile syntax with `caddy validate`

2. **Database connection issues**
   - Make sure PostgreSQL is running
   - Check database credentials in `.env`

3. **Email not sending**
   - Verify SMTP settings in `.env`
   - Check notification service logs

## 📄 License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## 🤝 Contributing

1. Fork the repository
2. Create a feature branch
3. Commit your changes
4. Push to the branch
5. Create a new Pull Request

## 📧 Contact

For support, email support@example.com or open an issue on GitHub.


System uploadów z **pełną separacją autoryzacji od logiki biznesowej**

## Główne Założenia

### **1. Kompletna Separacja Auth od Business Logic**
- **Caddy** - zarządza domenami i autoryzacją na poziomie proxy
- **Auth Service** - zewnętrzny provider uwierzytelniania
- **Business Services** - zero logiki auth, tylko headers z user info

### **2. Elastyczność Domen/Portów**
```bash
# Development
FRONTEND_DOMAIN=upload.localhost
API_DOMAIN=api.localhost

# Production  
FRONTEND_DOMAIN=upload.mycompany.com
API_DOMAIN=api.mycompany.com

# Custom ports
HTTP_PORT=8080
HTTPS_PORT=8443
```

### **3. Workflow jak opisałeś:**
1. **Public upload** (bez auth) → `upload.localhost`
2. **WebDAV storage** z file management  
3. **Manager approval** (auth przez Caddy) → `manager.localhost`
4. **Email notification** (config przez admina)
5. **Admin configuration** (auth przez Caddy) → `admin.localhost`

### **4. Technologie:**
- **Node.js** - Upload & Notification services
- **Groovy/Spring Boot** - Approval workflow engine
- **Python/FastAPI** - Configuration management
- **React** - Wszystkie frontendy (public, manager, admin)
- **WebDAV** - File storage z web access
- **Caddy** - Reverse proxy z auto-HTTPS

## **🚀 Uruchomienie:**

```bash
# Setup
cp .env.example .env
docker-compose up -d

# Access
http://upload.localhost      # Public upload
http://manager.localhost     # Manager dashboard  
http://admin.localhost       # Admin config
http://files.localhost       # WebDAV files
```

## **✅ Korzyści Architektury:**

1. **Zero Auth w Business Code** - usługi otrzymują user info przez headers
2. **Domain Flexibility** - zmiana domen bez modyfikacji kodu
3. **Auto HTTPS** - Caddy zarządza certyfikatami
4. **Microservices Ready** - każda usługa niezależna
5. **WebDAV Integration** - pliki dostępne przez web interface
6. **Event-Driven** - asynchroniczne przetwarzanie



## Prerequisites

- Docker and Docker Compose
- Node.js (for development)
- Git

## Quick Start

1. Clone the repository:
   ```bash
   git clone https://github.com/wronai/beepload.git
   cd beepload
   ```

2. Copy the example environment file and update it with your settings:
   ```bash
   cp .env.example .env
   # Edit .env with your configuration
   ```

3. Generate required secrets:
   ```bash
   # Generate WebDAV password hash
   docker run --rm caddy:2-alpine caddy hash-password --plaintext "your-webdav-password"
   # Add the output to WEBDAV_PASSWORD_HASH in .env
   ```

4. Start the services:
   ```bash
   docker-compose up -d
   ```

5. Access the applications:
   - Public Upload: http://upload.localhost
   - Manager Dashboard: http://manager.localhost
   - Admin Dashboard: http://admin.localhost
   - Auth Service: http://auth.localhost

## Development

### Project Structure

```
beepload/
├── docker-compose.yml          # Main Docker Compose configuration
├── Caddyfile                   # Reverse proxy configuration
├── .env.example                # Environment variables template
├── kratos/                     # Ory Kratos configuration
├── services/                   # Backend services
│   ├── upload-service/        # File upload service (Node.js)
│   ├── approval-service/      # Approval workflow (Groovy)
│   ├── config-service/        # Configuration service (Python)
│   └── notification-service/  # Email notifications (Node.js)
├── frontend/                  # Public upload interface
├── manager-frontend/          # Manager dashboard
├── admin-frontend/            # Admin configuration panel
└── webdav-storage/            # File storage
```

### Environment Variables

See `.env.example` for all available configuration options.

### Building Services

Each service has its own `Dockerfile` and can be built separately:

```bash
docker-compose build <service-name>
```

Or build all services:

```bash
docker-compose build
```

## Security

- Always use HTTPS in production
- Change all default passwords and secrets
- Keep your dependencies updated
- Regularly backup your database

## License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

# Ultimate Upload System - Kompletna Separacja Autoryzacji

## Struktura Projektu

```
ultimate-upload-system/
├── docker-compose.yml              # Ultimate setup
├── Caddyfile                       # Reverse proxy + auth
├── .env.example                    # Environment template
├── kratos/                         # Identity management
├── services/
│   ├── upload-service/            # Node.js - uploads (no auth)
│   ├── approval-service/          # Groovy - approval workflow (no auth)
│   ├── config-service/           # Python - configuration (no auth)
│   ├── notification-service/     # Node.js - email sending (no auth)
│   └── auth-service/             # External auth provider
├── frontend/                     # React - public upload form
├── manager-frontend/            # React - manager dashboard
├── admin-frontend/              # React - admin config
└── webdav-storage/              # File storage
```



## 10. Deployment and Usage

### Quick Start

```bash
# 1. Clone and setup
git clone <repository>
cd ultimate-upload-system
cp .env.example .env

# 2. Start everything
docker-compose up -d

# 3. Create initial admin user (one-time setup)
docker-compose exec auth-service node scripts/create-admin.js

# 4. Access the applications:
# - Public upload: http://upload.localhost
# - Manager dashboard: http://manager.localhost
# - Admin panel: http://admin.localhost
# - WebDAV files: http://files.localhost (requires manager login)
```

### Usage Workflow

1. **Public User uploads file** → `upload.localhost`
   - No authentication required
   - File stored in WebDAV
   - Notification sent to approval queue

2. **Manager reviews uploads** → `manager.localhost`
   - Manager logs in (handled by Caddy + Auth Service)
   - Views pending uploads
   - Can preview files via WebDAV
   - Approves or rejects

3. **Approved files trigger email** → Automatic
   - Notification service sends email to uploader
   - Uses admin-configured SMTP settings
   - Download link provided

4. **Admin configures system** → `admin.localhost`
   - Admin-only access
   - Configure email settings
   - Test email functionality

### Key Benefits

✅ **Complete Auth Separation** - No auth logic in business services
✅ **Domain/Port Flexibility** - Change via environment variables only
✅ **Zero-Config HTTPS** - Automatic SSL certificates
✅ **Scalable Architecture** - Each service independent
✅ **WebDAV Integration** - File storage with web access
✅ **Groovy Business Logic** - Powerful workflow engine
✅ **Real-time Processing** - Event-driven architecture

This system demonstrates perfect separation of concerns where authorization is handled entirely at the infrastructure level, allowing business services to focus purely on their domain logic.










---

## **🎯 Główne Założenia Spełnione:**

### **1. Kompletna Separacja Auth od Business Logic**
- **Caddy** - zarządza domenami i autoryzacją na poziomie proxy
- **Auth Service** - zewnętrzny provider uwierzytelniania
- **Business Services** - zero logiki auth, tylko headers z user info

### **2. Elastyczność Domen/Portów**
```bash
# Development
FRONTEND_DOMAIN=upload.localhost
API_DOMAIN=api.localhost

# Production  
FRONTEND_DOMAIN=upload.mycompany.com
API_DOMAIN=api.mycompany.com

# Custom ports
HTTP_PORT=8080
HTTPS_PORT=8443
```

### **3. Workflow jak opisałeś:**
1. **Public upload** (bez auth) → `upload.localhost`
2. **WebDAV storage** z file management  
3. **Manager approval** (auth przez Caddy) → `manager.localhost`
4. **Email notification** (config przez admina)
5. **Admin configuration** (auth przez Caddy) → `admin.localhost`

### **4. Technologie:**
- **Node.js** - Upload & Notification services
- **Groovy/Spring Boot** - Approval workflow engine
- **Python/FastAPI** - Configuration management
- **React** - Wszystkie frontendy (public, manager, admin)
- **WebDAV** - File storage z web access
- **Caddy** - Reverse proxy z auto-HTTPS

## **🚀 Uruchomienie:**

```bash
# Setup
cp .env.example .env
docker-compose up -d

# Access
http://upload.localhost      # Public upload
http://manager.localhost     # Manager dashboard  
http://admin.localhost       # Admin config
http://files.localhost       # WebDAV files
```

## **✅ Korzyści Architektury:**

1. **Zero Auth w Business Code** - usługi otrzymują user info przez headers
2. **Domain Flexibility** - zmiana domen bez modyfikacji kodu
3. **Auto HTTPS** - Caddy zarządza certyfikatami
4. **Microservices Ready** - każda usługa niezależna
5. **WebDAV Integration** - pliki dostępne przez web interface
6. **Event-Driven** - asynchroniczne przetwarzanie


















## 9. Environment Configuration

```bash
# .env.example
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

# ============ ENVIRONMENT ============
NODE_ENV=development
PYTHON_ENV=development
GROOVY_ENV=development

# ============ SECURITY ============
JWT_SECRET=your-super-secret-jwt-key-change-in-production
POSTGRES_PASSWORD=postgresSecretPassword
KRATOS_DB_PASSWORD=kratosSuperSecretPassword
CONFIG_DB_PASSWORD=configSecretPassword

# ============ PRODUCTION EXAMPLE ============
# FRONTEND_DOMAIN=upload.mycompany.com
# API_DOMAIN=api.mycompany.com
# MANAGER_DOMAIN=manager.mycompany.com
# ADMIN_DOMAIN=admin.mycompany.com
# HTTP_PORT=80
# HTTPS_PORT=443

# ============ DEVELOPMENT WITH CUSTOM PORTS ============
# HTTP_PORT=8080
# HTTPS_PORT=8443
```

## Deployment and Usage

### Quick Start

```bash
# 1. Clone and setup
git clone <repository>
cd ultimate-upload-system
cp .env.example .env

# 2. Start everything
docker-compose up -d

# 3. Create initial admin user (one-time setup)
docker-compose exec auth-service node scripts/create-admin.js

# 4. Access the applications:
# - Public upload: http://upload.localhost
# - Manager dashboard: http://manager.localhost
# - Admin panel: http://admin.localhost
# - WebDAV files: http://files.localhost (requires manager login)
```

### Usage Workflow

1. **Public User uploads file** → `upload.localhost`
   - No authentication required
   - File stored in WebDAV
   - Notification sent to approval queue

2. **Manager reviews uploads** → `manager.localhost`
   - Manager logs in (handled by Caddy + Auth Service)
   - Views pending uploads
   - Can preview files via WebDAV
   - Approves or rejects

3. **Approved files trigger email** → Automatic
   - Notification service sends email to uploader
   - Uses admin-configured SMTP settings
   - Download link provided

4. **Admin configures system** → `admin.localhost`
   - Admin-only access
   - Configure email settings
   - Test email functionality

### Key Benefits

✅ **Complete Auth Separation** - No auth logic in business services
✅ **Domain/Port Flexibility** - Change via environment variables only
✅ **Zero-Config HTTPS** - Automatic SSL certificates
✅ **Scalable Architecture** - Each service independent
✅ **WebDAV Integration** - File storage with web access
✅ **Groovy Business Logic** - Powerful workflow engine
✅ **Real-time Processing** - Event-driven architecture

This system demonstrates perfect separation of concerns where authorization is handled entirely at the infrastructure level, allowing business services to focus purely on their domain logic.
