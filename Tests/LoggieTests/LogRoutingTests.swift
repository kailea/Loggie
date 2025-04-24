import Testing
@testable import Loggie

@Test
func routingLogToMockDestination() async throws {
	let logger = Logger()
	await logger.removeAllDestinations()
	let mock = MockDestination(identifier: "mock1")
	await logger.addDestination(mock)

	await logger.info("Test from Loggie", metadata: ["user": "john"])

	#expect(mock.loggedMessages.count == 1)
	#expect(mock.loggedMessages[0].0 == .info)
	#expect(mock.loggedMessages[0].1 == "Test from Loggie")
	#expect(mock.loggedMessages[0].2?["user"] as? String == "john")
}

@Test
func destinationRemoval() async throws {
	let logger = Logger()
	await logger.removeAllDestinations()
	let mock = MockDestination(identifier: "mock2")
	await logger.addDestination(mock)
	await logger.removeDestination(withIdentifier: "mock2")

	await logger.error("Should not reach")

	#expect(mock.loggedMessages.isEmpty)
}

@Test
func debugLevelLog() async throws {
	let logger = Logger()

	let mock = MockDestination(identifier: "debug-test")
	await logger.addDestination(mock)

	await logger.debug("Debugging mode", metadata: ["debugFlag": true])

	#expect(mock.loggedMessages.count == 1)
	#expect(mock.loggedMessages[0].0 == .debug)
	#expect(mock.loggedMessages[0].1 == "Debugging mode")
	#expect(mock.loggedMessages[0].2?["debugFlag"] as? Bool == true)
}

@Test
func warningLevelLog() async throws {
	let logger = Logger()

	let mock = MockDestination(identifier: "warning-test")
	await logger.addDestination(mock)

	await logger.warning("Watch out!", metadata: ["threshold": 85])

	#expect(mock.loggedMessages.count == 1)
	#expect(mock.loggedMessages[0].0 == .warning)
	#expect(mock.loggedMessages[0].1 == "Watch out!")
	#expect(mock.loggedMessages[0].2?["threshold"] as? Int == 85)
}
