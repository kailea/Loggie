//
//  File.swift
//  Loggie
//
//  Created by Amandeep Kaile on 24/4/2025.
//

import Foundation

import Foundation

public class WebhookLogger: LogDestination {
	public let identifier = "webhook"
	private let endpoint: URL
	
	public init(endpoint: URL) {
		self.endpoint = endpoint
	}
	
	public func log(level: LogLevel, message: String, metadata: [String: Any]? = nil) {
		var payload: [String: Any] = [
			"level": level.rawValue,
			"message": message,
			"timestamp": ISO8601DateFormatter().string(from: Date())
		]
		
		if let metadata = metadata {
			payload["metadata"] = metadata
		}
		
		print("🔗 Sending to \(endpoint.absoluteString): \(payload)")
	}
}
