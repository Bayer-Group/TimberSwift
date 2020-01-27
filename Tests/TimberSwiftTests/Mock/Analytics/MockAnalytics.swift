@testable import TimberSwift

class MockAnalytics: AnalyticsProtocol {

	final class Stub {
		
		var recordEventCallCount = 0
		var recordEventCalledWith = [(title: String, properties: [String: Any]?)]()
		var setScreenCallCount = 0
		var setScreenCalledWith = [String]()
	}

	var stub = Stub()

	func parrotResetMock() {
		stub = Stub()
	}

	func recordEvent(title: String, properties: [String: Any]?) {
		stub.recordEventCallCount += 1
		stub.recordEventCalledWith.append((title, properties))
	}

	func setScreen(title: String) {
		stub.setScreenCallCount += 1
		stub.setScreenCalledWith.append(title)
	}

}
