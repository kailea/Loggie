//
//  File.swift
//  Loggie
//
//  Created by Amandeep Kaile on 24/4/2025.
//

import Foundation

public protocol LogDestination {
	var identifier: String { get }
	func log(level: LogLevel, message: String, metadata: [String: Any]?)
}
