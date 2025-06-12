package com.beepload.approval

import org.springframework.web.bind.annotation.GetMapping
import org.springframework.web.bind.annotation.RequestMapping
import org.springframework.web.bind.annotation.RestController

@RestController
@RequestMapping("/api/approval")
class ApprovalController {
    
    @GetMapping("/status")
    fun status(): Map<String, String> {
        return mapOf("status" to "Approval Service is running")
    }
}
