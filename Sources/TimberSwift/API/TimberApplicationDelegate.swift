import Foundation

/**
 A set of functions which are called when an associated action in a timber instance is performed.
 */
public protocol TimberApplicationDelegate: AnyObject {
    /** The delegation from Analytics setScreen */
    func setScreen(title: String, source: Source)
    /** The delegation from Analytics recordEvent */
    func recordEvent(title: String, properties: [String: Any]?, source: Source)
    /** The delegation from Log for any log level including error */
    func log(message: LogMessage)
    /** The delegation from Log for a error */
    func log(error: TimberError)
    /** The delegation from UserMessage for a user facing message */
    func toast(message: String, displayTime: TimeInterval, type: ToastType, source: Source)
    /** The delegation from Performance for starting a trace */
    func startTrace(key: String, identifier: UUID?, properties: [String: Any]?, source: Source)
    /** The delegation from Performance for incrementing a trace by name and a specific amount */
    func incrementTraceCounter(key: String, identifier: UUID?, named: String, by count: Int, source: Source)
    /** The delegation from Performance for stopping a trace */
    func stopTrace(key: String, identifier: UUID?, source: Source)
    /** The delegation from Network to notify the parent app that network activity has started */
    func networkActivityStarted(source: Source)
    /** The delegation from Network to notify the parent app that network activity has ended */
    func networkActivityEnded(source: Source)
}
