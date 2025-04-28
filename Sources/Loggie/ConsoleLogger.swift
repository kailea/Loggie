//
//  File.swift
//  Loggie
//
//  Created by Amandeep Kaile on 24/4/2025.
//
import Foundation

public class ConsoleLogger: LogDestination {
	public let identifier = "console"
	
	public init() {}
	
	public func log(level: LogLevel, message: String, metadata: [String : Any]?) {
		var output = "[\(level.rawValue)] \(message)"
		if let metadata = metadata {
			output += " | Metadata: \(metadata)"
		}
		print(output)
	}
}
