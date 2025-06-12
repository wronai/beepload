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