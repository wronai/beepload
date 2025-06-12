
# Ultimate Upload System - Simplified Installer
# Complete infrastructure separation with minimal files

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
    echo "║                     Simplified Infrastructure Setup                         ║"
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

# Detect environment
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

    # Check Docker
    if ! command -v docker &> /dev/null; then
        print_error "Docker is not installed"
        install_docker
    else
        print_success "Docker is installed"
    fi

    # Check Docker Compose
    if ! command -v docker-compose &> /dev/null && ! docker compose version &> /dev/null; then
        print_error "Docker Compose is not installed"
        install_docker_compose
    else
        print_success "Docker Compose is installed"
    fi
}

# Install Docker
install_docker() {
    print_step "Installing Docker"

    if [[ "$OSTYPE" == "linux-gnu"* ]]; then
        curl -fsSL https://get.docker.com -o get-docker.sh
        sudo sh get-docker.sh
        sudo usermod -aG docker $USER
        print_success "Docker installed successfully"
        print_warning "Please logout and login again to use Docker without sudo"
    else
        print_info "Please install Docker Desktop from https://www.docker.com/products/docker-desktop"
        exit 1
    fi
}

# Install Docker Compose
install_docker_compose() {
    print_step "Installing Docker Compose"

    DOCKER_COMPOSE_VERSION=$(curl -s https://api.github.com/repos/docker/compose/releases/latest | grep tag_name | cut -d '"' -f 4)
    sudo curl -L "https://github.com/docker/compose/releases/download/${DOCKER_COMPOSE_VERSION}/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
    sudo chmod +x /usr/local/bin/docker-compose

    print_success "Docker Compose installed successfully"
}

# Create simplified project structure
create_project_structure() {
    print_step "Creating simplified project structure"

    # Remove existing directory if it exists
    if [[ -d "$PROJECT_DIR" ]]; then
        print_warning "Project directory already exists. Backing up..."
        mv "$PROJECT_DIR" "${PROJECT_DIR}.backup.$(date +%Y%m%d_%H%M%S)"
    fi

    # Create minimal structure
    mkdir -p "$PROJECT_DIR"
    cd "$PROJECT_DIR"

    # Only essential directories
    mkdir -p {services,frontend,scripts}

    print_success "Simplified project structure created"
}

# Generate unified frontend
generate_frontend() {
    print_step "Generating unified frontend application"

    # Package.json
    cat > frontend/package.json << 'EOF'
{
  "name": "upload-system-frontend",
  "version": "1.0.0",
  "private": true,
  "dependencies": {
    "react": "^18.2.0",
    "react-dom": "^18.2.0",
    "react-scripts": "5.0.1",
    "react-router-dom": "^6.18.0",
    "axios": "^1.6.0"
  },
  "scripts": {
    "start": "react-scripts start",
    "build": "react-scripts build"
  },
  "browserslist": {
    "production": [">0.2%", "not dead", "not op_mini all"],
    "development": ["last 1 chrome version", "last 1 firefox version", "last 1 safari version"]
  }
}
EOF

    # Main App component with routing
    cat > frontend/src/App.js << 'EOF'
import React, { useState, useEffect } from 'react';
import { BrowserRouter as Router, Routes, Route, Navigate } from 'react-router-dom';
import axios from 'axios';
import './App.css';

const API_URL = process.env.REACT_APP_API_URL || 'http://api.localhost';

// ============ PUBLIC UPLOAD PAGE ============
function PublicUpload() {
  const [file, setFile] = useState(null);
  const [description, setDescription] = useState('');
  const [uploaderEmail, setUploaderEmail] = useState('');
  const [uploading, setUploading] = useState(false);
  const [result, setResult] = useState(null);

  const handleSubmit = async (e) => {
    e.preventDefault();
    if (!file || !uploaderEmail) return;

    setUploading(true);
    const formData = new FormData();
    formData.append('file', file);
    formData.append('description', description);
    formData.append('uploaderEmail', uploaderEmail);

    try {
      const response = await axios.post(`${API_URL}/api/upload`, formData);
      setResult({ success: true, message: response.data.message, uploadId: response.data.uploadId });
      setFile(null); setDescription(''); setUploaderEmail('');
    } catch (error) {
      setResult({ success: false, message: error.response?.data?.error || 'Upload failed' });
    } finally {
      setUploading(false);
    }
  };

  return (
    <div className="page">
      <h1>🚀 File Upload System</h1>
      <p>Upload your files for approval. No account required!</p>

      <form onSubmit={handleSubmit} className="upload-form">
        <input
          type="email"
          placeholder="Your email address"
          value={uploaderEmail}
          onChange={(e) => setUploaderEmail(e.target.value)}
          required
        />

        <div className="file-input-wrapper">
          <input
            type="file"
            onChange={(e) => setFile(e.target.files[0])}
            required
          />
          {file && <span className="file-name">{file.name}</span>}
        </div>

        <textarea
          placeholder="Description (optional)"
          value={description}
          onChange={(e) => setDescription(e.target.value)}
        />

        <button type="submit" disabled={uploading}>
          {uploading ? 'Uploading...' : 'Upload File'}
        </button>
      </form>

      {result && (
        <div className={`result ${result.success ? 'success' : 'error'}`}>
          <p>{result.message}</p>
          {result.success && <p><strong>Upload ID:</strong> {result.uploadId}</p>}
        </div>
      )}
    </div>
  );
}

// ============ LOGIN PAGE ============
function Login({ onLogin }) {
  const [email, setEmail] = useState('');
  const [password, setPassword] = useState('');
  const [error, setError] = useState('');
  const [loading, setLoading] = useState(false);

  const handleSubmit = async (e) => {
    e.preventDefault();
    setLoading(true);
    setError('');

    try {
      const response = await axios.post(`${API_URL}/auth/login`, { email, password });
      localStorage.setItem('authToken', response.data.token);
      localStorage.setItem('user', JSON.stringify(response.data.user));
      onLogin(response.data.user);
    } catch (error) {
      setError('Invalid credentials');
    } finally {
      setLoading(false);
    }
  };

  return (
    <div className="page">
      <h1>🔐 Login</h1>

      <form onSubmit={handleSubmit} className="login-form">
        <input
          type="email"
          placeholder="Email"
          value={email}
          onChange={(e) => setEmail(e.target.value)}
          required
        />
        <input
          type="password"
          placeholder="Password"
          value={password}
          onChange={(e) => setPassword(e.target.value)}
          required
        />
        <button type="submit" disabled={loading}>
          {loading ? 'Logging in...' : 'Login'}
        </button>
      </form>

      {error && <div className="result error">{error}</div>}

      <div className="login-help">
        <h3>Demo Credentials:</h3>
        <p><strong>Admin:</strong> admin@company.com / admin123</p>
        <p><strong>Manager:</strong> manager@company.com / manager123</p>
      </div>
    </div>
  );
}

// ============ MANAGER DASHBOARD ============
function ManagerDashboard({ user, onLogout }) {
  const [uploads, setUploads] = useState([]);
  const [loading, setLoading] = useState(true);

  const loadUploads = async () => {
    try {
      const response = await axios.get(`${API_URL}/api/manager/pending`, {
        headers: { 'Authorization': `Bearer ${localStorage.getItem('authToken')}` }
      });
      setUploads(response.data.uploads);
    } catch (error) {
      console.error('Failed to load uploads:', error);
    } finally {
      setLoading(false);
    }
  };

  const approveUpload = async (id) => {
    try {
      await axios.post(`${API_URL}/api/manager/approve/${id}`, {}, {
        headers: { 'Authorization': `Bearer ${localStorage.getItem('authToken')}` }
      });
      loadUploads();
    } catch (error) {
      alert('Failed to approve upload');
    }
  };

  const rejectUpload = async (id) => {
    const reason = prompt('Rejection reason:');
    if (!reason) return;

    try {
      await axios.post(`${API_URL}/api/manager/reject/${id}`, { reason }, {
        headers: { 'Authorization': `Bearer ${localStorage.getItem('authToken')}` }
      });
      loadUploads();
    } catch (error) {
      alert('Failed to reject upload');
    }
  };

  useEffect(() => {
    loadUploads();
  }, []);

  if (loading) return <div className="loading">Loading...</div>;

  return (
    <div className="page">
      <header className="dashboard-header">
        <h1>📋 Manager Dashboard</h1>
        <div>
          <span>Welcome, {user.email}</span>
          <button onClick={onLogout} className="logout-btn">Logout</button>
        </div>
      </header>

      <div className="stats">
        <div className="stat-card">
          <div className="stat-number">{uploads.length}</div>
          <div className="stat-label">Pending Uploads</div>
        </div>
      </div>

      <div className="uploads-grid">
        {uploads.length === 0 ? (
          <div className="empty-state">
            <h3>No pending uploads</h3>
            <p>All caught up!</p>
          </div>
        ) : (
          uploads.map(upload => (
            <div key={upload.id} className="upload-card">
              <h3>{upload.original_name}</h3>
              <p><strong>From:</strong> {upload.uploader_email}</p>
              <p><strong>Size:</strong> {Math.round(upload.size / 1024)} KB</p>
              <p><strong>Uploaded:</strong> {new Date(upload.uploaded_at).toLocaleDateString()}</p>
              {upload.description && <p><strong>Description:</strong> {upload.description}</p>}

              <div className="upload-actions">
                <button onClick={() => approveUpload(upload.id)} className="approve-btn">
                  ✅ Approve
                </button>
                <button onClick={() => rejectUpload(upload.id)} className="reject-btn">
                  ❌ Reject
                </button>
              </div>
            </div>
          ))
        )}
      </div>
    </div>
  );
}

// ============ ADMIN PANEL ============
function AdminPanel({ user, onLogout }) {
  const [config, setConfig] = useState({
    smtp_host: '', smtp_port: 587, smtp_username: '', smtp_password: '',
    from_email: '', from_name: ''
  });
  const [saving, setSaving] = useState(false);
  const [testing, setTesting] = useState(false);
  const [result, setResult] = useState(null);

  const loadConfig = async () => {
    try {
      const response = await axios.get(`${API_URL}/api/admin/config`, {
        headers: { 'Authorization': `Bearer ${localStorage.getItem('authToken')}` }
      });
      setConfig({ ...config, ...response.data });
    } catch (error) {
      console.error('Failed to load config:', error);
    }
  };

  const saveConfig = async (e) => {
    e.preventDefault();
    setSaving(true);

    try {
      await axios.put(`${API_URL}/api/admin/config`, config, {
        headers: { 'Authorization': `Bearer ${localStorage.getItem('authToken')}` }
      });
      setResult({ success: true, message: 'Configuration saved successfully!' });
    } catch (error) {
      setResult({ success: false, message: 'Failed to save configuration' });
    } finally {
      setSaving(false);
    }
  };

  const testEmail = async () => {
    setTesting(true);

    try {
      const response = await axios.post(`${API_URL}/api/admin/test-email`, {}, {
        headers: { 'Authorization': `Bearer ${localStorage.getItem('authToken')}` }
      });
      setResult({ success: response.data.success, message: response.data.message || response.data.error });
    } catch (error) {
      setResult({ success: false, message: 'Test email failed' });
    } finally {
      setTesting(false);
    }
  };

  useEffect(() => {
    loadConfig();
  }, []);

  return (
    <div className="page">
      <header className="dashboard-header">
        <h1>⚙️ Admin Panel</h1>
        <div>
          <span>Welcome, {user.email}</span>
          <button onClick={onLogout} className="logout-btn">Logout</button>
        </div>
      </header>

      <div className="config-section">
        <h2>📧 Email Configuration</h2>

        <form onSubmit={saveConfig} className="config-form">
          <div className="form-grid">
            <input
              type="text"
              placeholder="SMTP Host (e.g., smtp.gmail.com)"
              value={config.smtp_host}
              onChange={(e) => setConfig({...config, smtp_host: e.target.value})}
            />
            <input
              type="number"
              placeholder="SMTP Port (587)"
              value={config.smtp_port}
              onChange={(e) => setConfig({...config, smtp_port: parseInt(e.target.value)})}
            />
            <input
              type="text"
              placeholder="SMTP Username"
              value={config.smtp_username}
              onChange={(e) => setConfig({...config, smtp_username: e.target.value})}
            />
            <input
              type="password"
              placeholder="SMTP Password"
              value={config.smtp_password}
              onChange={(e) => setConfig({...config, smtp_password: e.target.value})}
            />
            <input
              type="email"
              placeholder="From Email"
              value={config.from_email}
              onChange={(e) => setConfig({...config, from_email: e.target.value})}
            />
            <input
              type="text"
              placeholder="From Name"
              value={config.from_name}
              onChange={(e) => setConfig({...config, from_name: e.target.value})}
            />
          </div>

          <div className="form-actions">
            <button type="submit" disabled={saving}>
              {saving ? 'Saving...' : 'Save Configuration'}
            </button>
            <button type="button" onClick={testEmail} disabled={testing}>
              {testing ? 'Testing...' : 'Test Email'}
            </button>
          </div>
        </form>

        {result && (
          <div className={`result ${result.success ? 'success' : 'error'}`}>
            {result.message}
          </div>
        )}
      </div>
    </div>
  );
}

// ============ MAIN APP ============
function App() {
  const [user, setUser] = useState(null);
  const [loading, setLoading] = useState(true);

  useEffect(() => {
    const token = localStorage.getItem('authToken');
    const userData = localStorage.getItem('user');

    if (token && userData) {
      setUser(JSON.parse(userData));
    }
    setLoading(false);
  }, []);

  const handleLogin = (userData) => {
    setUser(userData);
  };

  const handleLogout = () => {
    localStorage.removeItem('authToken');
    localStorage.removeItem('user');
    setUser(null);
  };

  if (loading) return <div className="loading">Loading...</div>;

  // Determine which interface to show based on URL
  const isManagerDomain = window.location.hostname.includes('manager');
  const isAdminDomain = window.location.hostname.includes('admin');

  if (isManagerDomain || isAdminDomain) {
    // Protected routes
    if (!user) {
      return <Login onLogin={handleLogin} />;
    }

    if (isManagerDomain && (user.roles.includes('manager') || user.roles.includes('admin'))) {
      return <ManagerDashboard user={user} onLogout={handleLogout} />;
    }

    if (isAdminDomain && user.roles.includes('admin')) {
      return <AdminPanel user={user} onLogout={handleLogout} />;
    }

    return (
      <div className="page">
        <h1>Access Denied</h1>
        <p>You don't have permission to access this area.</p>
        <button onClick={handleLogout}>Logout</button>
      </div>
    );
  }

  // Public upload interface
  return <PublicUpload />;
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
  font-family: -apple-system, BlinkMacSystemFont, 'Segoe UI', 'Roboto', sans-serif;
  background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
  min-height: 100vh;
  line-height: 1.6;
}

.page {
  max-width: 1200px;
  margin: 0 auto;
  padding: 20px;
  min-height: 100vh;
}

h1 {
  color: white;
  text-align: center;
  margin-bottom: 10px;
  font-size: 2.5rem;
}

h2 {
  color: #333;
  margin-bottom: 20px;
}

h3 {
  color: #333;
  margin-bottom: 10px;
}

p {
  color: white;
  text-align: center;
  margin-bottom: 30px;
  font-size: 1.1rem;
}

/* Forms */
.upload-form, .login-form, .config-form {
  background: white;
  padding: 30px;
  border-radius: 12px;
  box-shadow: 0 10px 30px rgba(0, 0, 0, 0.1);
  max-width: 600px;
  margin: 0 auto;
}

.upload-form input, .upload-form textarea,
.login-form input, .config-form input {
  width: 100%;
  padding: 12px 16px;
  border: 2px solid #e0e0e0;
  border-radius: 8px;
  margin-bottom: 15px;
  font-size: 1rem;
  transition: border-color 0.3s ease;
}

.upload-form input:focus, .upload-form textarea:focus,
.login-form input:focus, .config-form input:focus {
  outline: none;
  border-color: #667eea;
}

.file-input-wrapper {
  position: relative;
  margin-bottom: 15px;
}

.file-name {
  display: block;
  margin-top: 5px;
  color: #666;
  font-size: 0.9rem;
}

button {
  background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
  color: white;
  border: none;
  padding: 12px 24px;
  border-radius: 8px;
  font-size: 1rem;
  font-weight: 600;
  cursor: pointer;
  transition: all 0.3s ease;
  width: 100%;
}

button:hover:not(:disabled) {
  transform: translateY(-2px);
  box-shadow: 0 5px 15px rgba(102, 126, 234, 0.4);
}

button:disabled {
  opacity: 0.6;
  cursor: not-allowed;
  transform: none;
}

/* Results */
.result {
  margin-top: 20px;
  padding: 15px;
  border-radius: 8px;
  text-align: center;
}

.result.success {
  background: #d4edda;
  color: #155724;
  border: 1px solid #c3e6cb;
}

.result.error {
  background: #f8d7da;
  color: #721c24;
  border: 1px solid #f5c6cb;
}

/* Dashboard */
.dashboard-header {
  background: white;
  padding: 20px;
  border-radius: 12px;
  margin-bottom: 20px;
  display: flex;
  justify-content: space-between;
  align-items: center;
  box-shadow: 0 2px 10px rgba(0, 0, 0, 0.1);
}

.dashboard-header h1 {
  color: #333;
  font-size: 1.8rem;
  margin: 0;
}

.dashboard-header span {
  color: #666;
  margin-right: 15px;
}

.logout-btn {
  background: #dc3545;
  width: auto;
  padding: 8px 16px;
  font-size: 0.9rem;
}

.logout-btn:hover {
  background: #c82333;
  box-shadow: 0 3px 10px rgba(220, 53, 69, 0.3);
}

.stats {
  display: flex;
  gap: 20px;
  margin-bottom: 30px;
}

.stat-card {
  background: white;
  padding: 20px;
  border-radius: 12px;
  text-align: center;
  box-shadow: 0 2px 10px rgba(0, 0, 0, 0.1);
  min-width: 150px;
}

.stat-number {
  font-size: 2.5rem;
  font-weight: bold;
  color: #667eea;
}

.stat-label {
  color: #666;
  font-size: 1rem;
}

/* Upload Cards */
.uploads-grid {
  display: grid;
  grid-template-columns: repeat(auto-fill, minmax(350px, 1fr));
  gap: 20px;
}

.upload-card {
  background: white;
  padding: 20px;
  border-radius: 12px;
  box-shadow: 0 2px 10px rgba(0, 0, 0, 0.1);
  transition: transform 0.3s ease;
}

.upload-card:hover {
  transform: translateY(-5px);
}

.upload-card h3 {
  color: #333;
  margin-bottom: 10px;
  word-break: break-word;
}

.upload-card p {
  color: #666;
  text-align: left;
  margin-bottom: 8px;
  font-size: 0.9rem;
}

.upload-actions {
  display: flex;
  gap: 10px;
  margin-top: 15px;
}

.upload-actions button {
  flex: 1;
  padding: 8px 12px;
  font-size: 0.85rem;
  width: auto;
}

.approve-btn {
  background: #28a745;
}

.approve-btn:hover:not(:disabled) {
  background: #218838;
  box-shadow: 0 3px 10px rgba(40, 167, 69, 0.3);
}

.reject-btn {
  background: #dc3545;
}

.reject-btn:hover:not(:disabled) {
  background: #c82333;
  box-shadow: 0 3px 10px rgba(220, 53, 69, 0.3);
}

/* Config Section */
.config-section {
  background: white;
  padding: 30px;
  border-radius: 12px;
  box-shadow: 0 2px 10px rgba(0, 0, 0, 0.1);
}

.form-grid {
  display: grid;
  grid-template-columns: repeat(auto-fit, minmax(250px, 1fr));
  gap: 15px;
  margin-bottom: 20px;
}

.form-actions {
  display: flex;
  gap: 15px;
}

.form-actions button {
  flex: 1;
  width: auto;
}

/* Empty State */
.empty-state {
  text-align: center;
  padding: 40px;
  color: #666;
  background: white;
  border-radius: 12px;
  box-shadow: 0 2px 10px rgba(0, 0, 0, 0.1);
}

/* Login Help */
.login-help {
  background: rgba(255, 255, 255, 0.1);
  padding: 20px;
  border-radius: 12px;
  margin-top: 20px;
  text-align: center;
}

.login-help h3 {
  color: white;
  margin-bottom: 10px;
}

.login-help p {
  color: rgba(255, 255, 255, 0.9);
  margin-bottom: 5px;
  font-size: 0.9rem;
}

/* Loading */
.loading {
  display: flex;
  justify-content: center;
  align-items: center;
  min-height: 100vh;
  color: white;
  font-size: 1.2rem;
}

/* Responsive */
@media (max-width: 768px) {
  .page {
    padding: 10px;
  }

  h1 {
    font-size: 2rem;
  }

  .dashboard-header {
    flex-direction: column;
    gap: 15px;
    text-align: center;
  }

  .stats {
    justify-content: center;
  }

  .uploads-grid {
    grid-template-columns: 1fr;
  }

  .form-grid {
    grid-template-columns: 1fr;
  }

  .form-actions {
    flex-direction: column;
  }

  .upload-actions {
    flex-direction: column;
  }
}
EOF

    # Index.js
    cat > frontend/src/index.js << 'EOF'
import React from 'react';
import ReactDOM from 'react-dom/client';
import App from './App';

const root = ReactDOM.createRoot(document.getElementById('root'));
root.render(<App />);
EOF

    # Public HTML
    cat > frontend/public/index.html << 'EOF'
<!DOCTYPE html>
<html lang="en">
  <head>
    <meta charset="utf-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1" />
    <meta name="description" content="Ultimate Upload System" />
    <title>Ultimate Upload System</title>
  </head>
  <body>
    <div id="root"></div>
  </body>
</html>
EOF

    # Dockerfile
    cat > frontend/Dockerfile << 'EOF'
# Build stage
FROM node:18-alpine AS build
WORKDIR /app
COPY package*.json ./
RUN npm ci
COPY src/ ./src/
COPY public/ ./public/
RUN npm run build

# Production stage
FROM nginx:alpine
COPY --from=build /app/build /usr/share/nginx/html

# Nginx configuration
RUN echo 'server { \
    listen 3000; \
    location / { \
        root /usr/share/nginx/html; \
        index index.html; \
        try_files $uri $uri/ /index.html; \
    } \
}' > /etc/nginx/conf.d/default.conf

EXPOSE 3000
CMD ["nginx", "-g", "daemon off;"]
EOF

    print_success "Frontend application generated"
}

# Generate deployment scripts
generate_scripts() {
    print_step "Generating deployment scripts"

    # Quick start script
    cat > scripts/start.sh << 'EOF'
#!/bin/bash
echo "🚀 Starting Ultimate Upload System..."

# Check if .env exists
if [ ! -f .env ]; then
    echo "📝 Creating .env from template..."
    cp .env.example .env
fi

# Start services
docker-compose up -d --build

echo "⏳ Waiting for services to be ready..."
sleep 30

echo "✅ Ultimate Upload System is ready!"
echo ""
echo "📱 Access URLs:"
echo "   Public Upload:     http://upload.localhost"
echo "   Manager Dashboard: http://manager.localhost"
echo "   Admin Panel:       http://admin.localhost"
echo ""
echo "🔐 Demo Credentials:"
echo "   Admin:   admin@company.com / admin123"
echo "   Manager: manager@company.com / manager123"
echo ""
echo "📋 Commands:"
echo "   View logs: docker-compose logs -f"
echo "   Stop:      docker-compose down"
EOF

    chmod +x scripts/start.sh

    # VPS deployment script
    cat > scripts/deploy-vps.sh << 'EOF'
#!/bin/bash
echo "🌐 Deploying to VPS..."

read -p "Enter your domain (e.g., yourdomain.com): " DOMAIN
if [ -z "$DOMAIN" ]; then
    echo "❌ Domain is required"
    exit 1
fi

# Generate production .env
cat > .env << EOF
FRONTEND_DOMAIN=upload.$DOMAIN
API_DOMAIN=api.$DOMAIN
MANAGER_DOMAIN=manager.$DOMAIN
ADMIN_DOMAIN=admin.$DOMAIN
HTTP_PORT=80
HTTPS_PORT=443
NODE_ENV=production
JWT_SECRET=$(openssl rand -base64 32)
POSTGRES_PASSWORD=$(openssl rand -base64 16)
EOF

echo "✅ Production environment configured for: $DOMAIN"

# Build and start
docker-compose build
docker-compose up -d

echo "✅ Deployment completed!"
echo "Your system is available at:"
echo "   https://upload.$DOMAIN"
echo "   https://manager.$DOMAIN"
echo "   https://admin.$DOMAIN"
EOF

    chmod +x scripts/deploy-vps.sh

    # Stop script
    cat > scripts/stop.sh << 'EOF'
#!/bin/bash
echo "🛑 Stopping Ultimate Upload System..."
docker-compose down
echo "✅ Stopped"
EOF

    chmod +x scripts/stop.sh

    print_success "Scripts generated"
}

# Generate documentation
generate_documentation() {
    print_step "Generating documentation"

    cat > README.md << 'EOF'
# Ultimate Upload System

Complete file upload system with infrastructure separation architecture.

## 🚀 Features

- **Public File Upload** - No authentication required
- **Manager Approval Workflow** - Files require approval before download
- **Admin Configuration** - Email settings configurable by admin
- **Email Notifications** - Automatic notifications on approval/rejection
- **External Authentication** - Auth handled at infrastructure level
- **Domain Flexibility** - Easy configuration via environment variables

## 🏗️ Architecture

- **Caddy Proxy** - Handles routing, HTTPS, and authentication
- **All-in-One Backend** - Node.js service with all business logic
- **Unified Frontend** - React SPA with routing for all interfaces
- **PostgreSQL** - Database storage
- **Redis** - Session storage

## 🚀 Quick Start

### Local Development

```bash
# 1. Start the system
./scripts/start.sh

# 2. Access the applications
# Public Upload:     http://upload.localhost
# Manager Dashboard: http://manager.localhost (manager@company.com / manager123)
# Admin Panel:       http://admin.localhost (admin@company.com / admin123)
```

### VPS Deployment

```bash
# 1. Deploy to production
./scripts/deploy-vps.sh

# 2. Follow prompts to configure your domain
```

## 🔧 Configuration

### Environment Variables

```bash
# Local Development
FRONTEND_DOMAIN=upload.localhost
API_DOMAIN=api.localhost
MANAGER_DOMAIN=manager.localhost
ADMIN_DOMAIN=admin.localhost

# Production
FRONTEND_DOMAIN=upload.yourdomain.com
API_DOMAIN=api.yourdomain.com
MANAGER_DOMAIN=manager.yourdomain.com
ADMIN_DOMAIN=admin.yourdomain.com
```

### Email Configuration

1. Login to admin panel
2. Configure SMTP settings
3. Test email functionality
4. Save configuration

## 📁 Project Structure

```
ultimate-upload-system/
├── docker-compose.yml          # Infrastructure setup
├── Caddyfile                   # Reverse proxy configuration
├── .env                        # Environment variables
├── services/                   # All-in-one backend
│   ├── app.js                  # Main application
│   ├── package.json            # Dependencies
│   └── Dockerfile              # Container config
├── frontend/                   # Unified React frontend
│   ├── src/App.js              # Main application with routing
│   ├── src/App.css             # Styles
│   ├── package.json            # Dependencies
│   └── Dockerfile              # Container config
└── scripts/                    # Deployment scripts
    ├── start.sh                # Quick start
    ├── deploy-vps.sh           # VPS deployment
    └── stop.sh                 # Stop services
```

## 🔐 Authentication

- **Public Access** - Upload interface requires no authentication
- **Manager Access** - Approve/reject files (manager@company.com / manager123)
- **Admin Access** - System configuration (admin@company.com / admin123)

## 🔄 Workflow

1. **User uploads file** → Public interface
2. **File stored** → Database + file system
3. **Manager reviews** → Approval dashboard
4. **Action taken** → Approve or reject with reason
5. **Email sent** → User notified of decision
6. **File available** → Download link for approved files

## 🛠️ Development

```bash
# View logs
docker-compose logs -f

# Restart specific service
docker-compose restart backend

# Access database
docker-compose exec postgres psql -U postgres -d uploaddb

# Access Redis
docker-compose exec redis redis-cli
```

## 🌐 Production Deployment

1. Point domain DNS to your VPS
2. Run `./scripts/deploy-vps.sh`
3. Configure email settings in admin panel
4. Change default passwords

## 🔧 Troubleshooting

### Services not starting
```bash
docker-compose logs
docker-compose restart
```

### Domain not resolving (local development)
Add to `/etc/hosts`:
```
127.0.0.1 upload.localhost api.localhost manager.localhost admin.localhost
```

### Reset everything
```bash
docker-compose down -v
./scripts/start.sh
```

## 📄 License

MIT License
EOF

    print_success "Documentation generated"
}

# Main execution flow
main() {
    print_header

    print_step "Starting Ultimate Upload System installation"

    detect_environment
    check_requirements
    create_project_structure

    generate_docker_compose
    generate_caddyfile
    generate_env_files
    generate_database_init

    generate_backend_service
    generate_frontend
    generate_scripts
    generate_documentation

    print_success "Installation completed successfully!"

    echo ""
    echo -e "${GREEN}🎉 Ultimate Upload System has been installed!${NC}"
    echo ""
    echo -e "${CYAN}📁 Project location:${NC} $PROJECT_DIR"
    echo ""
    echo -e "${YELLOW}🚀 Next steps:${NC}"
    echo -e "  ${BLUE}1.${NC} cd $PROJECT_NAME"
    echo -e "  ${BLUE}2.${NC} ./scripts/start.sh"
    echo -e "  ${BLUE}3.${NC} Access http://upload.localhost"
    echo ""
    echo -e "${CYAN}📖 Read the README.md for detailed instructions${NC}"
    echo ""

    if [[ "$ENVIRONMENT" == "vps" ]]; then
        echo -e "${YELLOW}🌐 For VPS deployment:${NC}"
        echo -e "  ${BLUE}1.${NC} ./scripts/deploy-vps.sh"
        echo -e "  ${BLUE}2.${NC} Configure your domain DNS"
        echo ""
    fi

    echo -e "${GREEN}✨ Happy uploading!${NC}"
}

# Run the installer
main "$@"#!/bin/bash
