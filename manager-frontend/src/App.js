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