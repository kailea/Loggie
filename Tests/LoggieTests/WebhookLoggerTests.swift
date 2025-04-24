//
//  Test.swift
//  Loggie
//
//  Created by Amandeep Kaile on 25/4/2025.
//

import Testing
@testable import Loggie
import Foundation

final class CapturingWebhookLogger: WebhookLogger {
	var capturedPayload: String?

	override public func log(level: LogLevel, message: String, metadata: [String: Any]? = nil) {
		let output = captureConsoleOutput {
			super.log(level: level, message: message, metadata: metadata)
		}
		capturedPayload = output
	}
}

@Test
func webhookLoggerCapturesLogPayload() {
	let logger = CapturingWebhookLogger(endpoint: URL(string: "https://example.com")!)
	logger.log(level: .error, message: "Webhook down", metadata: ["code": 503])

	#expect(logger.capturedPayload?.contains("Webhook down") == true)
	#expect(logger.capturedPayload?.contains("code") == true)
	#expect(logger.capturedPayload?.contains("503") == true)
	#expect(logger.capturedPayload?.contains("[ERROR]") == false)  // WebhookLogger doesn't prefix
}
