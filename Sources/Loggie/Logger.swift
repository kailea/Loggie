//
//  File.swift
//  Loggie
//
//  Created by Amandeep Kaile on 24/4/2025.
//

import Foundation

public actor Logger {
	private var destinations: [String: LogDestination] = [:]
	
	public init() {}
	
	public func addDestination(_ destination: LogDestination) {
		destinations[destination.identifier] = destination
	}
	
	public func removeDestination(withIdentifier identifier: String) {
		destinations.removeValue(forKey: identifier)
	}
	
	public func removeAllDestinations() {
		destinations.removeAll()
	}
	
	public func log(level: LogLevel, message: String, metadata: [String: Any]? = nil) {
		for destination in destinations.values {
			destination.log(level: level, message: message, metadata: metadata)
		}
	}
	
	public func debug(_ message: String, metadata: [String: Any]? = nil) {
		log(level: .debug, message: message, metadata: metadata)
	}
	
	public func info(_ message: String, metadata: [String: Any]? = nil) {
		log(level: .info, message: message, metadata: metadata)
	}
	
	public func warning(_ message: String, metadata: [String: Any]? = nil) {
		log(level: .warning, message: message, metadata: metadata)
	}
	
	public func error(_ message: String, metadata: [String: Any]? = nil) {
		log(level: .error, message: message, metadata: metadata)
	}
}

public extension Logger {
	static let shared = Logger()
}
