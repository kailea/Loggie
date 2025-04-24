import Testing
@testable import Loggie

@Test
func routingLogToMockDestination() async throws {
	let logger = Logger.shared
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
	let logger = Logger.shared
	await logger.removeAllDestinations()
	let mock = MockDestination(identifier: "mock2")
	await logger.addDestination(mock)
	await logger.removeDestination(withIdentifier: "mock2")

	await logger.error("Should not reach")

	#expect(mock.loggedMessages.isEmpty)
}
