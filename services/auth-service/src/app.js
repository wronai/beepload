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