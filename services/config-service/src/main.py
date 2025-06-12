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