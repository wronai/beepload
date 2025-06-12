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