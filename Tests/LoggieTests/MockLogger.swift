//
//  MockLogger.swift
//  Loggie
//
//  Created by Amandeep Kaile on 25/4/2025.
//

import Foundation
@testable import Loggie

final class MockDestination: LogDestination, @unchecked Sendable {
	let identifier: String
	var loggedMessages: [(LogLevel, String, [String: Any]?)] = []

	init(identifier: String) {
		self.identifier = identifier
	}

	func log(level: LogLevel, message: String, metadata: [String: Any]?) {
		loggedMessages.append((level, message, metadata))
	}
}
