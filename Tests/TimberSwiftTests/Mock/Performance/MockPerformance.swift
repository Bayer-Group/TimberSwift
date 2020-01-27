import Foundation

@testable import TimberSwift

class MockPerformance: PerformanceProtocol {

	final class Stub {
		
		var incrementTraceCounterCallCount = 0
		var incrementTraceCounterCalledWith = [(key: String, identifier: UUID?, named: String, count: Int)]()
		var startTraceCallCount = 0
		var startTraceCalledWith = [(key: String, identifier: UUID?, properties: [String: Any]?)]()
		var stopTraceCallCount = 0
		var stopTraceCalledWith = [(key: String, identifier: UUID?)]()
	}

	var stub = Stub()

	func parrotResetMock() {
		stub = Stub()
	}

	func incrementTraceCounter(key: String, identifier: UUID?, named: String, by count: Int) {
		stub.incrementTraceCounterCallCount += 1
		stub.incrementTraceCounterCalledWith.append((key, identifier, named, count))
	}

	func startTrace(key: String, identifier: UUID?, properties: [String: Any]?) {
		stub.startTraceCallCount += 1
		stub.startTraceCalledWith.append((key, identifier, properties))
	}

	func stopTrace(key: String, identifier: UUID?) {
		stub.stopTraceCallCount += 1
		stub.stopTraceCalledWith.append((key, identifier))
	}
}
