import Foundation

@testable import TimberSwift

class MockUserMessage: UserMessageProtocol {

	final class Stub {
		
		var toastCallCount = 0
		var toastCalledWith = [(message: String, displayTime: TimeInterval, type: ToastType)]()
	}

	var stub = Stub()

	func parrotResetMock() {
		stub = Stub()
	}

	func toast(_ message: String, displayTime: TimeInterval, type: ToastType) {
		stub.toastCallCount += 1
		stub.toastCalledWith.append((message, displayTime, type))
	}
}
