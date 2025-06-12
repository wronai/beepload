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