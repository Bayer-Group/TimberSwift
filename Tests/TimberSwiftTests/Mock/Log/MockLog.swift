@testable import TimberSwift

class MockLog: LogProtocol {

	final class Stub {
		
		var logCallCount = 0
		var logCalledWith = [(message: String, errorType: TimberErrorType?, properties: [String: Any]?, file: String, function: String, line: Int, logLevel: LogLevel)]()
	}

	var stub = Stub()

	func parrotResetMock() {
		stub = Stub()
	}

	func log(_ message: String, errorType: TimberErrorType?, properties: [String: Any]?, _ file: String, _ function: String, _ line: Int, logLevel: LogLevel) {
		stub.logCallCount += 1
		stub.logCalledWith.append((message, errorType, properties, file, function, line, logLevel))
	}
}
