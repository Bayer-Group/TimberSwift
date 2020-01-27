import Foundation

@testable import TimberSwift

class MockTimberApplicationDelegate: TimberApplicationDelegate {

	final class Stub {
		
		var incrementTraceCounterCallCount = 0
		var incrementTraceCounterCalledWith = [(key: String, identifier: UUID?, named: String, count: Int, source: Source)]()
		var logErrorCallCount = 0
		var logErrorCalledWith = [TimberError]()
		var logMessageCallCount = 0
		var logMessageCalledWith = [LogMessage]()
		var networkActivityEndedCallCount = 0
		var networkActivityEndedCalledWith = [Source]()
		var networkActivityStartedCallCount = 0
		var networkActivityStartedCalledWith = [Source]()
		var recordEventCallCount = 0
		var recordEventCalledWith = [(title: String, properties: [String: Any]?, source: Source)]()
		var setScreenCallCount = 0
		var setScreenCalledWith = [(title: String, source: Source)]()
		var startTraceCallCount = 0
		var startTraceCalledWith = [(key: String, identifier: UUID?, properties: [String: Any]?, source: Source)]()
		var stopTraceCallCount = 0
		var stopTraceCalledWith = [(key: String, identifier: UUID?, source: Source)]()
		var toastCallCount = 0
		var toastCalledWith = [(message: String, displayTime: TimeInterval, type: ToastType, source: Source)]()
	}

	var stub = Stub()

	func parrotResetMock() {
		stub = Stub()
	}

	func incrementTraceCounter(key: String, identifier: UUID?, named: String, by count: Int, source: Source) {
		stub.incrementTraceCounterCallCount += 1
		stub.incrementTraceCounterCalledWith.append((key, identifier, named, count, source))
	}

	func log(error: TimberError) {
		stub.logErrorCallCount += 1
		stub.logErrorCalledWith.append(error)
	}

	func log(message: LogMessage) {
		stub.logMessageCallCount += 1
		stub.logMessageCalledWith.append(message)
	}

	func networkActivityEnded(source: Source) {
		stub.networkActivityEndedCallCount += 1
		stub.networkActivityEndedCalledWith.append(source)
	}

	func networkActivityStarted(source: Source) {
		stub.networkActivityStartedCallCount += 1
		stub.networkActivityStartedCalledWith.append(source)
	}

	func recordEvent(title: String, properties: [String: Any]?, source: Source) {
		stub.recordEventCallCount += 1
		stub.recordEventCalledWith.append((title, properties, source))
	}

	func setScreen(title: String, source: Source) {
		stub.setScreenCallCount += 1
		stub.setScreenCalledWith.append((title, source))
	}

	func startTrace(key: String, identifier: UUID?, properties: [String: Any]?, source: Source) {
		stub.startTraceCallCount += 1
		stub.startTraceCalledWith.append((key, identifier, properties, source))
	}

	func stopTrace(key: String, identifier: UUID?, source: Source) {
		stub.stopTraceCallCount += 1
		stub.stopTraceCalledWith.append((key, identifier, source))
	}

	func toast(message: String, displayTime: TimeInterval, type: ToastType, source: Source) {
		stub.toastCallCount += 1
		stub.toastCalledWith.append((message, displayTime, type, source))
	}

}
