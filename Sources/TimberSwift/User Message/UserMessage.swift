import Foundation

public protocol UserMessageProtocol {
    /**
     Message to send to the parent app so it can display a toast message with its own styling.
     - parameter message: message to display in the toast message
     - parameter displayTime: how long before the toast will vanish
     - parameter type: type of toast to display
     */
    func toast(_ message: String, displayTime: TimeInterval, type: ToastType)
}

internal protocol UserMessageDelegate: AnyObject {
    func toast(message: String, displayTime: TimeInterval, type: ToastType)
}

internal class UserMessage: UserMessageProtocol {
    weak var userMessageDelegate: UserMessageDelegate?
    
    func toast(_ message: String, displayTime: TimeInterval, type: ToastType) { userMessageDelegate?.toast(message: message, displayTime: displayTime, type: type) }
}
