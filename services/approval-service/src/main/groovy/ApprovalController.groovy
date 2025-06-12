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
