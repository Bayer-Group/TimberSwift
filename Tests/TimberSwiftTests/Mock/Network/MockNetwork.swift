@testable import TimberSwift

class MockNetwork: NetworkProtocol {

	final class Stub {
		
		var endedActivityCallCount = 0
		var startedActivityCallCount = 0
	}

	var stub = Stub()

	func parrotResetMock() {
		stub = Stub()
	}

	func endedActivity() {
		stub.endedActivityCallCount += 1
	}

	func startedActivity() {
		stub.startedActivityCallCount += 1
	}
}
