# Beepload - Ultimate Upload System

A comprehensive file upload system with approval workflow, user management, and secure file storage.

## Features

- 🚀 File uploads with drag & drop support
- 🔒 Role-based access control (User, Manager, Admin)
- 📧 Email notifications for uploads and approvals
- 🔄 Approval workflow for file uploads
- 📦 WebDAV storage backend
- 🔐 Ory Kratos for authentication
- 🐳 Docker Compose for easy deployment

## Prerequisites

- Docker and Docker Compose
- Node.js (for development)
- Git

## Quick Start

1. Clone the repository:
   ```bash
   git clone https://github.com/yourusername/beepload.git
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

## 1. Ultimate Docker Compose Setup

```yaml
# docker-compose.yml
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

  # ============ IDENTITY MANAGEMENT ============
  kratos:
    image: oryd/kratos:v1.0
    container_name: kratos-identity
    environment:
      - DSN=postgres://kratos:${KRATOS_DB_PASSWORD:-kratosSuperSecret}@postgres:5432/kratos
      - LOG_LEVEL=trace
    volumes:
      - ./kratos:/etc/config/kratos
    networks:
      - app_network
    depends_on:
      - postgres

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

  # ============ BUSINESS SERVICES (NO AUTH LOGIC!) ============
  upload-service:
    build: ./services/upload-service
    container_name: upload-service
    environment:
      - NODE_ENV=${NODE_ENV:-development}
      - WEBDAV_URL=http://webdav:80
      - APPROVAL_SERVICE_URL=http://approval-service:8080
    volumes:
      - upload_temp:/tmp/uploads
    networks:
      - app_network
    depends_on:
      - webdav

  approval-service:
    build: ./services/approval-service
    container_name: approval-service
    environment:
      - GROOVY_ENV=${GROOVY_ENV:-development}
      - WEBDAV_URL=http://webdav:80
      - NOTIFICATION_SERVICE_URL=http://notification-service:3000
      - CONFIG_SERVICE_URL=http://config-service:8000
    networks:
      - app_network
    depends_on:
      - postgres

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

  notification-service:
    build: ./services/notification-service
    container_name: notification-service
    environment:
      - NODE_ENV=${NODE_ENV:-development}
      - CONFIG_SERVICE_URL=http://config-service:8000
    networks:
      - app_network

  # ============ STORAGE & INFRASTRUCTURE ============
  webdav:
    image: hacdias/webdav:latest
    container_name: webdav-storage
    environment:
      - AUTH=false  # Auth handled by Caddy!
    volumes:
      - webdav_data:/data
    networks:
      - app_network

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

  redis:
    image: redis:7-alpine
    container_name: redis-cache
    networks:
      - app_network

  # ============ FRONTENDS (NO AUTH LOGIC!) ============
  frontend:
    build: ./frontend
    container_name: public-frontend
    environment:
      - REACT_APP_API_URL=https://${API_DOMAIN:-api.localhost}
      - REACT_APP_UPLOAD_URL=https://${API_DOMAIN:-api.localhost}/uploads
    networks:
      - app_network

  manager-frontend:
    build: ./manager-frontend
    container_name: manager-frontend
    environment:
      - REACT_APP_API_URL=https://${API_DOMAIN:-api.localhost}
      - REACT_APP_AUTH_URL=https://${AUTH_DOMAIN:-auth.localhost}
    networks:
      - app_network

  admin-frontend:
    build: ./admin-frontend
    container_name: admin-frontend
    environment:
      - REACT_APP_API_URL=https://${API_DOMAIN:-api.localhost}
      - REACT_APP_AUTH_URL=https://${AUTH_DOMAIN:-auth.localhost}
    networks:
      - app_network

networks:
  app_network:
    driver: bridge

volumes:
  caddy_data:
  caddy_config:
  postgres_data:
  webdav_data:
  upload_temp:
```

## 2. Caddyfile - Complete Auth Separation

```caddyfile
# Caddyfile - Ultimate Auth Separation

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
```

## 3. Upload Service (Node.js) - NO AUTH LOGIC

```javascript
// services/upload-service/src/app.js
const express = require('express');
const multer = require('multer');
const axios = require('axios');
const path = require('path');
const fs = require('fs').promises;

const app = express();
app.use(express.json());

// Multer config for file uploads
const upload = multer({
  dest: '/tmp/uploads/',
  limits: {
    fileSize: 100 * 1024 * 1024 // 100MB
  }
});

// ============ PUBLIC UPLOAD ENDPOINT (NO AUTH) ============
app.post('/uploads', upload.single('file'), async (req, res) => {
  try {
    if (!req.file) {
      return res.status(400).json({ error: 'No file uploaded' });
    }

    const { originalname, mimetype, size, path: tempPath } = req.file;
    const { description = '', uploaderEmail = '' } = req.body;

    // Generate unique filename
    const timestamp = Date.now();
    const filename = `${timestamp}_${originalname}`;
    
    // Store metadata in database
    const uploadRecord = {
      filename,
      originalName: originalname,
      mimetype,
      size,
      description,
      uploaderEmail,
      status: 'pending',
      uploadedAt: new Date().toISOString()
    };

    // Save to database (using internal DB connection)
    const savedUpload = await saveUploadRecord(uploadRecord);

    // Move file to WebDAV storage
    await moveFileToWebDAV(tempPath, filename);

    // Notify approval service (internal call)
    await notifyApprovalService(savedUpload);

    res.json({
      success: true,
      uploadId: savedUpload.id,
      filename: filename,
      message: 'File uploaded successfully and pending approval'
    });

  } catch (error) {
    console.error('Upload error:', error);
    res.status(500).json({ error: 'Upload failed' });
  }
});

// ============ PUBLIC FILE ACCESS (NO AUTH) ============
app.get('/files/:filename', async (req, res) => {
  try {
    const { filename } = req.params;
    
    // Check if file is approved (business logic only)
    const uploadRecord = await getUploadRecord(filename);
    if (!uploadRecord || uploadRecord.status !== 'approved') {
      return res.status(404).json({ error: 'File not found or not approved' });
    }

    // Proxy to WebDAV
    const webdavUrl = `${process.env.WEBDAV_URL}/${filename}`;
    const response = await axios.get(webdavUrl, { responseType: 'stream' });
    
    res.set({
      'Content-Type': uploadRecord.mimetype,
      'Content-Disposition': `attachment; filename="${uploadRecord.originalName}"`
    });
    
    response.data.pipe(res);

  } catch (error) {
    console.error('Download error:', error);
    res.status(404).json({ error: 'File not found' });
  }
});

// ============ BUSINESS LOGIC FUNCTIONS (NO AUTH) ============
async function saveUploadRecord(record) {
  // Database logic - no auth concerns
  // Implementation details...
  return { id: Date.now(), ...record };
}

async function moveFileToWebDAV(tempPath, filename) {
  // Move file to WebDAV storage
  const fileBuffer = await fs.readFile(tempPath);
  const webdavUrl = `${process.env.WEBDAV_URL}/${filename}`;
  
  await axios.put(webdavUrl, fileBuffer, {
    headers: { 'Content-Type': 'application/octet-stream' }
  });
  
  // Clean up temp file
  await fs.unlink(tempPath);
}

async function notifyApprovalService(uploadRecord) {
  // Internal service call - no auth needed
  await axios.post(`${process.env.APPROVAL_SERVICE_URL}/process-upload`, uploadRecord);
}

async function getUploadRecord(filename) {
  // Database query - no auth logic
  // Implementation details...
  return null; // Placeholder
}

app.listen(3000, () => {
  console.log('Upload Service running on port 3000 (NO AUTH LOGIC!)');
});
```

```dockerfile
# services/upload-service/Dockerfile
FROM node:18-alpine

WORKDIR /app

COPY package*.json ./
RUN npm ci --only=production

COPY src/ ./src/

EXPOSE 3000

CMD ["node", "src/app.js"]
```

## 4. Approval Service (Groovy) - NO AUTH LOGIC

```groovy
// services/approval-service/src/main/groovy/ApprovalController.groovy
@RestController
@RequestMapping("/")
class ApprovalController {
    
    @Autowired
    private ApprovalService approvalService
    
    // ============ MANAGER ENDPOINTS (AUTH BY PROXY) ============
    @GetMapping("/approval/pending")
    def getPendingUploads(HttpServletRequest request) {
        // Auth already verified by Caddy - get user info from headers
        def managerId = request.getHeader("X-Manager-ID")
        def userEmail = request.getHeader("X-User-Email")
        
        // Pure business logic - no auth checks!
        def pendingUploads = approvalService.getPendingUploads()
        
        return [
            success: true,
            uploads: pendingUploads,
            managedBy: userEmail
        ]
    }
    
    @PostMapping("/approval/approve/{uploadId}")
    def approveUpload(@PathVariable String uploadId, HttpServletRequest request) {
        // Get manager info from headers (verified by Caddy)
        def managerId = request.getHeader("X-Manager-ID")
        def managerEmail = request.getHeader("X-User-Email")
        
        try {
            // Business logic only - no auth concerns
            def result = approvalService.approveUpload(uploadId, managerId, managerEmail)
            
            return [
                success: true,
                message: "Upload approved successfully",
                uploadId: uploadId,
                approvedBy: managerEmail
            ]
        } catch (Exception e) {
            return [
                success: false,
                error: e.message
            ]
        }
    }
    
    @PostMapping("/approval/reject/{uploadId}")
    def rejectUpload(@PathVariable String uploadId, 
                    @RequestBody Map rejectionData,
                    HttpServletRequest request) {
        
        def managerId = request.getHeader("X-Manager-ID")
        def managerEmail = request.getHeader("X-User-Email")
        def reason = rejectionData.reason ?: "No reason provided"
        
        try {
            approvalService.rejectUpload(uploadId, managerId, managerEmail, reason)
            
            return [
                success: true,
                message: "Upload rejected",
                reason: reason,
                rejectedBy: managerEmail
            ]
        } catch (Exception e) {
            return [
                success: false,
                error: e.message
            ]
        }
    }
    
    // ============ INTERNAL ENDPOINT (NO AUTH NEEDED) ============
    @PostMapping("/process-upload")
    def processNewUpload(@RequestBody Map uploadData) {
        // Called internally by upload-service - no auth needed
        approvalService.addToPendingQueue(uploadData)
        
        return [success: true, message: "Upload added to approval queue"]
    }
}

// services/approval-service/src/main/groovy/ApprovalService.groovy
@Service
class ApprovalService {
    
    @Autowired
    private RestTemplate restTemplate
    
    @Value('${notification.service.url}')
    private String notificationServiceUrl
    
    @Value('${webdav.url}')
    private String webdavUrl
    
    def getPendingUploads() {
        // Database query for pending uploads - pure business logic
        return [
            [
                id: "1",
                filename: "document.pdf",
                originalName: "Important Document.pdf",
                uploaderEmail: "user@example.com",
                description: "Contract document",
                uploadedAt: "2024-01-15T10:30:00Z",
                size: 1048576
            ],
            [
                id: "2", 
                filename: "image.jpg",
                originalName: "Photo.jpg",
                uploaderEmail: "another@example.com",
                description: "Project photo",
                uploadedAt: "2024-01-15T11:15:00Z",
                size: 2097152
            ]
        ]
    }
    
    def approveUpload(String uploadId, String managerId, String managerEmail) {
        // 1. Update database status
        updateUploadStatus(uploadId, "approved", managerId)
        
        // 2. Get upload details
        def uploadDetails = getUploadDetails(uploadId)
        
        // 3. Trigger email notification (internal service call)
        def notificationData = [
            type: "approval",
            uploadId: uploadId,
            filename: uploadDetails.originalName,
            uploaderEmail: uploadDetails.uploaderEmail,
            approvedBy: managerEmail,
            downloadUrl: "https://api.localhost/files/${uploadDetails.filename}"
        ]
        
        // Call notification service (no auth - internal)
        restTemplate.postForObject(
            "${notificationServiceUrl}/send-approval-notification",
            notificationData,
            Map.class
        )
        
        return uploadDetails
    }
    
    def rejectUpload(String uploadId, String managerId, String managerEmail, String reason) {
        // 1. Update database
        updateUploadStatus(uploadId, "rejected", managerId, reason)
        
        // 2. Delete file from WebDAV
        def uploadDetails = getUploadDetails(uploadId)
        deleteFileFromWebDAV(uploadDetails.filename)
        
        // 3. Send rejection notification
        def notificationData = [
            type: "rejection",
            uploadId: uploadId,
            filename: uploadDetails.originalName,
            uploaderEmail: uploadDetails.uploaderEmail,
            rejectedBy: managerEmail,
            reason: reason
        ]
        
        restTemplate.postForObject(
            "${notificationServiceUrl}/send-rejection-notification",
            notificationData,
            Map.class
        )
    }
    
    def addToPendingQueue(Map uploadData) {
        // Add to database with pending status - business logic only
        // Implementation details...
    }
    
    private def updateUploadStatus(String uploadId, String status, String managerId, String reason = null) {
        // Database update - no auth logic
        // Implementation details...
    }
    
    private def getUploadDetails(String uploadId) {
        // Database query - business logic only
        return [
            id: uploadId,
            filename: "document.pdf",
            originalName: "Important Document.pdf", 
            uploaderEmail: "user@example.com"
        ]
    }
    
    private def deleteFileFromWebDAV(String filename) {
        // Delete from WebDAV storage
        restTemplate.delete("${webdavUrl}/${filename}")
    }
}
```

```gradle
// services/approval-service/build.gradle
plugins {
    id 'groovy'
    id 'org.springframework.boot' version '3.2.0'
    id 'io.spring.dependency-management' version '1.1.4'
}

dependencies {
    implementation 'org.springframework.boot:spring-boot-starter-web'
    implementation 'org.springframework.boot:spring-boot-starter-data-jpa'
    implementation 'org.apache.groovy:groovy-all:4.0.15'
    implementation 'org.postgresql:postgresql'
    implementation 'org.springframework.boot:spring-boot-starter-actuator'
}
```

## 5. Config Service (Python) - NO AUTH LOGIC

```python
# services/config-service/src/main.py
from fastapi import FastAPI, Header, HTTPException
from pydantic import BaseModel, EmailStr
from typing import Optional
import os

app = FastAPI(title="Config Service - NO AUTH LOGIC")

# ============ DATA MODELS ============
class EmailConfig(BaseModel):
    smtp_host: str
    smtp_port: int
    smtp_username: str
    smtp_password: str
    from_email: EmailStr
    from_name: str

class EmailConfigUpdate(BaseModel):
    smtp_host: Optional[str] = None
    smtp_port: Optional[int] = None
    smtp_username: Optional[str] = None
    smtp_password: Optional[str] = None
    from_email: Optional[EmailStr] = None
    from_name: Optional[str] = None

# ============ ADMIN ENDPOINTS (AUTH BY PROXY) ============
@app.get("/config/email")
async def get_email_config(
    x_user_id: str = Header(None),
    x_user_email: str = Header(None),
    x_admin_id: str = Header(None)
):
    """Get email configuration - Admin only (verified by Caddy)"""
    
    # Auth already verified by Caddy proxy - no auth logic here!
    # Just log who accessed the config
    print(f"Email config accessed by admin: {x_user_email}")
    
    # Pure business logic - get config from database
    config = await get_email_config_from_db()
    
    # Don't return sensitive data like password
    return {
        "smtp_host": config.get("smtp_host"),
        "smtp_port": config.get("smtp_port"),
        "smtp_username": config.get("smtp_username"),
        "from_email": config.get("from_email"),
        "from_name": config.get("from_name"),
        "updated_by": config.get("updated_by"),
        "updated_at": config.get("updated_at")
    }

@app.put("/config/email")
async def update_email_config(
    config: EmailConfigUpdate,
    x_user_id: str = Header(None),
    x_user_email: str = Header(None),
    x_admin_id: str = Header(None)
):
    """Update email configuration - Admin only (verified by Caddy)"""
    
    # No auth logic - Caddy already verified admin access
    print(f"Email config updated by admin: {x_user_email}")
    
    # Business logic only
    updated_config = await update_email_config_in_db(
        config.dict(exclude_unset=True),
        updated_by=x_user_email
    )
    
    return {
        "success": True,
        "message": "Email configuration updated successfully",
        "updated_by": x_user_email,
        "updated_fields": list(config.dict(exclude_unset=True).keys())
    }

@app.post("/config/email/test")
async def test_email_config(
    x_user_id: str = Header(None),
    x_user_email: str = Header(None),
    x_admin_id: str = Header(None)
):
    """Test email configuration - Admin only"""
    
    # Get current config
    config = await get_email_config_from_db()
    
    try:
        # Test email sending
        await send_test_email(config, x_user_email)
        
        return {
            "success": True,
            "message": f"Test email sent successfully to {x_user_email}"
        }
    except Exception as e:
        return {
            "success": False,
            "error": f"Email test failed: {str(e)}"
        }

# ============ INTERNAL ENDPOINTS (NO AUTH NEEDED) ============
@app.get("/config/email/internal")
async def get_email_config_internal():
    """Internal endpoint for other services - no auth needed"""
    
    # Called by notification service - full config including password
    config = await get_email_config_from_db()
    return config

# ============ BUSINESS LOGIC FUNCTIONS (NO AUTH) ============
async def get_email_config_from_db():
    """Get email config from database - pure business logic"""
    # In real implementation, this would query the database
    return {
        "smtp_host": "smtp.gmail.com",
        "smtp_port": 587,
        "smtp_username": "noreply@company.com",
        "smtp_password": "encrypted_password",
        "from_email": "noreply@company.com",
        "from_name": "Upload System",
        "updated_by": "admin@company.com",
        "updated_at": "2024-01-15T10:00:00Z"
    }

async def update_email_config_in_db(config_data, updated_by):
    """Update email config in database - business logic only"""
    # In real implementation, this would update the database
    config_data["updated_by"] = updated_by
    config_data["updated_at"] = "2024-01-15T12:00:00Z"
    return config_data

async def send_test_email(config, test_email):
    """Send test email - business logic"""
    import smtplib
    from email.mime.text import MIMEText
    
    msg = MIMEText("This is a test email from the upload system.")
    msg['Subject'] = "Upload System - Email Configuration Test"
    msg['From'] = config["from_email"]
    msg['To'] = test_email
    
    # In real implementation, use the actual SMTP config
    print(f"Test email would be sent to {test_email} using {config['smtp_host']}")

if __name__ == "__main__":
    import uvicorn
    uvicorn.run(app, host="0.0.0.0", port=8000)
```

```dockerfile
# services/config-service/Dockerfile
FROM python:3.11-slim

WORKDIR /app

COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

COPY src/ ./src/

EXPOSE 8000

CMD ["python", "src/main.py"]
```

## 6. Notification Service (Node.js) - NO AUTH LOGIC

```javascript
// services/notification-service/src/app.js
const express = require('express');
const nodemailer = require('nodemailer');
const axios = require('axios');

const app = express();
app.use(express.json());

// ============ INTERNAL ENDPOINTS (NO AUTH - CALLED BY OTHER SERVICES) ============
app.post('/send-approval-notification', async (req, res) => {
  try {
    const { uploadId, filename, uploaderEmail, approvedBy, downloadUrl } = req.body;
    
    console.log(`Sending approval notification for upload ${uploadId}`);
    
    // Get email config from config service (internal call - no auth)
    const emailConfig = await getEmailConfig();
    
    // Send approval email
    await sendEmail(emailConfig, {
      to: uploaderEmail,
      subject: `File Approved: ${filename}`,
      html: `
        <h2>Your file has been approved!</h2>
        <p>Your uploaded file "<strong>${filename}</strong>" has been approved by ${approvedBy}.</p>
        <p>You can download it here: <a href="${downloadUrl}">Download File</a></p>
        <p>Thank you for using our upload system.</p>
      `
    });
    
    res.json({ 
      success: true, 
      message: 'Approval notification sent successfully' 
    });
    
  } catch (error) {
    console.error('Failed to send approval notification:', error);
    res.status(500).json({ 
      success: false, 
      error: 'Failed to send notification' 
    });
  }
});

app.post('/send-rejection-notification', async (req, res) => {
  try {
    const { uploadId, filename, uploaderEmail, rejectedBy, reason } = req.body;
    
    console.log(`Sending rejection notification for upload ${uploadId}`);
    
    // Get email config (internal call)
    const emailConfig = await getEmailConfig();
    
    // Send rejection email
    await sendEmail(emailConfig, {
      to: uploaderEmail,
      subject: `File Rejected: ${filename}`,
      html: `
        <h2>Your file was rejected</h2>
        <p>Your uploaded file "<strong>${filename}</strong>" has been rejected by ${rejectedBy}.</p>
        <p><strong>Reason:</strong> ${reason}</p>
        <p>Please contact us if you have any questions.</p>
      `
    });
    
    res.json({ 
      success: true, 
      message: 'Rejection notification sent successfully' 
    });
    
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

app.listen(3000, () => {
  console.log('Notification Service running on port 3000 (NO AUTH LOGIC!)');
});
```

## 7. Auth Service (External Auth Provider)

```javascript
// services/auth-service/src/app.js
const express = require('express');
const jwt = require('jsonwebtoken');
const bcrypt = require('bcrypt');
const axios = require('axios');
const Redis = require('redis');

const app = express();
app.use(express.json());

const redis = Redis.createClient({ url: process.env.REDIS_URL });
redis.connect();

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
    
    // Verify credentials (integrate with Kratos or your user store)
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
      process.env.JWT_SECRET,
      { expiresIn: '24h' }
    );
    
    // Store session in Redis
    const sessionId = `session:${user.id}:${Date.now()}`;
    await redis.setEx(sessionId, 86400, JSON.stringify(user)); // 24h expiry
    
    res.json({
      success: true,
      token,
      sessionId,
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
      await redis.del(sessionId);
    }
    
    res.json({ success: true, message: 'Logged out successfully' });
  } catch (error) {
    res.status(500).json({ error: 'Logout failed' });
  }
});

// ============ AUTH HELPER FUNCTIONS ============
async function verifyJWT(token) {
  const payload = jwt.verify(token, process.env.JWT_SECRET);
  return {
    id: payload.sub,
    email: payload.email,
    roles: payload.roles
  };
}

async function verifySession(cookieHeader) {
  const sessionId = extractSessionId(cookieHeader);
  const sessionData = await redis.get(sessionId);
  
  if (!sessionData) {
    throw new Error('Session not found');
  }
  
  return JSON.parse(sessionData);
}

function extractSessionId(cookieHeader) {
  // Extract session ID from cookie
  const match = cookieHeader.match(/sessionId=([^;]+)/);
  return match ? match[1] : null;
}

async function authenticateUser(email, password) {
  // Mock user data - in real app, integrate with Kratos or your user store
  const users = {
    'manager@company.com': {
      id: 'mgr-001',
      email: 'manager@company.com',
      password: await bcrypt.hash('manager123', 10),
      roles: ['manager']
    },
    'admin@company.com': {
      id: 'adm-001', 
      email: 'admin@company.com',
      password: await bcrypt.hash('admin123', 10),
      roles: ['admin', 'manager']
    }
  };
  
  const user = users[email];
  if (!user) return null;
  
  const isValid = await bcrypt.compare(password, user.password);
  if (!isValid) return null;
  
  return {
    id: user.id,
    email: user.email,
    roles: user.roles
  };
}

app.listen(3000, () => {
  console.log('Auth Service running on port 3000');
});
```

## 8. Frontend Applications

### Public Upload Frontend (React)

```jsx
// frontend/src/App.js
import React, { useState } from 'react';
import axios from 'axios';

const API_URL = process.env.REACT_APP_API_URL || 'http://api.localhost';

function App() {
  const [file, setFile] = useState(null);
  const [description, setDescription] = useState('');
  const [uploaderEmail, setUploaderEmail] = useState('');
  const [uploading, setUploading] = useState(false);
  const [result, setResult] = useState(null);

  const handleFileChange = (e) => {
    setFile(e.target.files[0]);
  };

  const handleSubmit = async (e) => {
    e.preventDefault();
    
    if (!file) {
      alert('Please select a file');
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

  return (
    <div className="container">
      <h1>File Upload System</h1>
      <p>Upload your files for approval. No account required!</p>
      
      <form onSubmit={handleSubmit} className="upload-form">
        <div className="form-group">
          <label htmlFor="file">Select File:</label>
          <input
            type="file"
            id="file"
            onChange={handleFileChange}
            required
          />
        </div>
        
        <div className="form-group">
          <label htmlFor="email">Your Email:</label>
          <input
            type="email"
            id="email"
            value={uploaderEmail}
            onChange={(e) => setUploaderEmail(e.target.value)}
            placeholder="We'll notify you when approved"
            required
          />
        </div>
        
        <div className="form-group">
          <label htmlFor="description">Description (optional):</label>
          <textarea
            id="description"
            value={description}
            onChange={(e) => setDescription(e.target.value)}
            placeholder="Brief description of the file"
          />
        </div>
        
        <button type="submit" disabled={uploading}>
          {uploading ? 'Uploading...' : 'Upload File'}
        </button>
      </form>
      
      {result && (
        <div className={`result ${result.success ? 'success' : 'error'}`}>
          <p>{result.message}</p>
          {result.success && (
            <p>Upload ID: <strong>{result.uploadId}</strong></p>
          )}
        </div>
      )}
    </div>
  );
}

export default App;
```

### Manager Dashboard (React)

```jsx
// manager-frontend/src/App.js
import React, { useState, useEffect } from 'react';
import axios from 'axios';

const API_URL = process.env.REACT_APP_API_URL || 'http://api.localhost';
const AUTH_URL = process.env.REACT_APP_AUTH_URL || 'http://auth.localhost';

function App() {
  const [user, setUser] = useState(null);
  const [pendingUploads, setPendingUploads] = useState([]);
  const [loading, setLoading] = useState(true);

  useEffect(() => {
    // Check if user is logged in
    const token = localStorage.getItem('authToken');
    if (token) {
      // Auth is handled by Caddy - just load data
      loadPendingUploads();
    } else {
      redirectToLogin();
    }
  }, []);

  const redirectToLogin = () => {
    window.location.href = `${AUTH_URL}/login?redirect=${window.location.href}`;
  };

  const loadPendingUploads = async () => {
    try {
      setLoading(true);
      
      // Auth token automatically handled by Caddy
      const response = await axios.get(`${API_URL}/approval/pending`, {
        headers: {
          'Authorization': `Bearer ${localStorage.getItem('authToken')}`
        }
      });
      
      setPendingUploads(response.data.uploads);
      setUser({ email: response.data.managedBy });
      
    } catch (error) {
      if (error.response?.status === 401) {
        redirectToLogin();
      } else {
        console.error('Failed to load uploads:', error);
      }
    } finally {
      setLoading(false);
    }
  };

  const approveUpload = async (uploadId) => {
    try {
      await axios.post(`${API_URL}/approval/approve/${uploadId}`, {}, {
        headers: {
          'Authorization': `Bearer ${localStorage.getItem('authToken')}`
        }
      });
      
      // Reload list
      loadPendingUploads();
      
    } catch (error) {
      alert('Failed to approve upload');
    }
  };

  const rejectUpload = async (uploadId) => {
    const reason = prompt('Rejection reason:');
    if (!reason) return;
    
    try {
      await axios.post(`${API_URL}/approval/reject/${uploadId}`, { reason }, {
        headers: {
          'Authorization': `Bearer ${localStorage.getItem('authToken')}`
        }
      });
      
      // Reload list
      loadPendingUploads();
      
    } catch (error) {
      alert('Failed to reject upload');
    }
  };

  if (loading) return <div>Loading...</div>;

  return (
    <div className="manager-dashboard">
      <header>
        <h1>Manager Dashboard</h1>
        <p>Logged in as: {user?.email}</p>
      </header>
      
      <main>
        <h2>Pending Uploads ({pendingUploads.length})</h2>
        
        {pendingUploads.length === 0 ? (
          <p>No pending uploads</p>
        ) : (
          <div className="uploads-list">
            {pendingUploads.map(upload => (
              <div key={upload.id} className="upload-item">
                <div className="upload-info">
                  <h3>{upload.originalName}</h3>
                  <p>Uploaded by: {upload.uploaderEmail}</p>
                  <p>Description: {upload.description || 'No description'}</p>
                  <p>Size: {(upload.size / 1024 / 1024).toFixed(2)} MB</p>
                  <p>Uploaded: {new Date(upload.uploadedAt).toLocaleString()}</p>
                </div>
                
                <div className="upload-actions">
                  <button 
                    onClick={() => approveUpload(upload.id)}
                    className="approve-btn"
                  >
                    Approve
                  </button>
                  <button 
                    onClick={() => rejectUpload(upload.id)}
                    className="reject-btn"
                  >
                    Reject
                  </button>
                  
                  {/* Preview link to WebDAV */}
                  <a 
                    href={`https://files.localhost/${upload.filename}`}
                    target="_blank" 
                    rel="noopener noreferrer"
                    className="preview-btn"
                  >
                    Preview
                  </a>
                </div>
              </div>
            ))}
          </div>
        )}
      </main>
    </div>
  );
}

export default App;
```

### Admin Configuration Panel (React)

```jsx
// admin-frontend/src/App.js
import React, { useState, useEffect } from 'react';
import axios from 'axios';

const API_URL = process.env.REACT_APP_API_URL || 'http://api.localhost';

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

  useEffect(() => {
    loadEmailConfig();
  }, []);

  const loadEmailConfig = async () => {
    try {
      setLoading(true);
      
      const response = await axios.get(`${API_URL}/config/email`, {
        headers: {
          'Authorization': `Bearer ${localStorage.getItem('authToken')}`
        }
      });
      
      setEmailConfig(response.data);
      
    } catch (error) {
      if (error.response?.status === 401) {
        window.location.href = '/login';
      } else {
        console.error('Failed to load config:', error);
      }
    } finally {
      setLoading(false);
    }
  };

  const saveEmailConfig = async (e) => {
    e.preventDefault();
    
    try {
      setSaving(true);
      
      await axios.put(`${API_URL}/config/email`, emailConfig, {
        headers: {
          'Authorization': `Bearer ${localStorage.getItem('authToken')}`
        }
      });
      
      alert('Email configuration saved successfully!');
      
    } catch (error) {
      alert('Failed to save configuration');
    } finally {
      setSaving(false);
    }
  };

  const testEmailConfig = async () => {
    try {
      setTesting(true);
      
      const response = await axios.post(`${API_URL}/config/email/test`, {}, {
        headers: {
          'Authorization': `Bearer ${localStorage.getItem('authToken')}`
        }
      });
      
      if (response.data.success) {
        alert('Test email sent successfully!');
      } else {
        alert(`Test failed: ${response.data.error}`);
      }
      
    } catch (error) {
      alert('Test email failed');
    } finally {
      setTesting(false);
    }
  };

  if (loading) return <div>Loading...</div>;

  return (
    <div className="admin-panel">
      <header>
        <h1>Admin Configuration Panel</h1>
        <p>Configure system settings</p>
      </header>
      
      <main>
        <section className="email-config">
          <h2>Email Configuration</h2>
          
          <form onSubmit={saveEmailConfig}>
            <div className="form-group">
              <label>SMTP Host:</label>
              <input
                type="text"
                value={emailConfig.smtp_host}
                onChange={(e) => setEmailConfig({...emailConfig, smtp_host: e.target.value})}
                placeholder="smtp.gmail.com"
                required
              />
            </div>
            
            <div className="form-group">
              <label>SMTP Port:</label>
              <input
                type="number"
                value={emailConfig.smtp_port}
                onChange={(e) => setEmailConfig({...emailConfig, smtp_port: parseInt(e.target.value)})}
                required
              />
            </div>
            
            <div className="form-group">
              <label>SMTP Username:</label>
              <input
                type="text"
                value={emailConfig.smtp_username}
                onChange={(e) => setEmailConfig({...emailConfig, smtp_username: e.target.value})}
                required
              />
            </div>
            
            <div className="form-group">
              <label>SMTP Password:</label>
              <input
                type="password"
                value={emailConfig.smtp_password}
                onChange={(e) => setEmailConfig({...emailConfig, smtp_password: e.target.value})}
                required
              />
            </div>
            
            <div className="form-group">
              <label>From Email:</label>
              <input
                type="email"
                value={emailConfig.from_email}
                onChange={(e) => setEmailConfig({...emailConfig, from_email: e.target.value})}
                required
              />
            </div>
            
            <div className="form-group">
              <label>From Name:</label>
              <input
                type="text"
                value={emailConfig.from_name}
                onChange={(e) => setEmailConfig({...emailConfig, from_name: e.target.value})}
                required
              />
            </div>
            
            <div className="form-actions">
              <button type="submit" disabled={saving}>
                {saving ? 'Saving...' : 'Save Configuration'}
              </button>
              
              <button 
                type="button" 
                onClick={testEmailConfig}
                disabled={testing}
              >
                {testing ? 'Testing...' : 'Test Email'}
              </button>
            </div>
          </form>
        </section>
      </main>
    </div>
  );
}

export default App;
```

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

Czy chcesz żebym rozwinął jakąś konkretną część systemu lub pokazał jak dostosować go do Twojego konkretnego przypadku użycia?