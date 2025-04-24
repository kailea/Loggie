//
//  Test.swift
//  Loggie
//
//  Created by Amandeep Kaile on 25/4/2025.
//

import Testing
@testable import Loggie
import Foundation

func captureConsoleOutput(_ block: () -> Void) -> String {
	let pipe = Pipe()
	let originalStdOut = dup(STDOUT_FILENO)

	// Redirect stdout to the pipe
	dup2(pipe.fileHandleForWriting.fileDescriptor, STDOUT_FILENO)

	// Run the block while stdout is redirected
	block()

	// Flush stdout and restore original
	fflush(stdout)
	dup2(originalStdOut, STDOUT_FILENO)
	close(originalStdOut)
	pipe.fileHandleForWriting.closeFile() // 🧠 THIS IS CRUCIAL

	let data = pipe.fileHandleForReading.readDataToEndOfFile()
	return String(decoding: data, as: UTF8.self)
}

@Test
func consoleLoggerDebugOutput() {
	let logger = ConsoleLogger()

	let output = captureConsoleOutput {
		logger.log(level: .debug, message: "Testing ConsoleLogger", metadata: ["env": "test"])
	}

	#expect(output.contains("[DEBUG] Testing ConsoleLogger"))
	#expect(output.contains("env: test") || output.contains("\"env\": \"test\""))  // depends on how metadata is printed
}

@Test
func consoleLoggerWithoutMetadata() {
	let logger = ConsoleLogger()

	let output = captureConsoleOutput {
		logger.log(level: .info, message: "No metadata here", metadata: nil)
	}

	#expect(output.contains("[INFO] No metadata here"))
}
