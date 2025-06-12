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