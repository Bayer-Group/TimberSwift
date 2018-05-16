import Foundation

/**
 A set of functions which are called when an associated action in a timber instance is performed.
 */
public protocol TimberApplicationDelegate: class {
    /** The delegation from Analytics setScreen */
    func setScreen(title: String, source: Source)
    /** The delegation from Analytics recordEvent */
    func recordEvent(title: String, properties: [String: Any]?, source: Source)
    /** The delegation from Log for any log level including error */
    func log(_ logMessage: LogMessage)
    /** The delegation from Log for a error */
    func log(_ error: TimberError)
    /** The delegation from Message for a toast message */
    func toast(_ message: String, displayTime: TimeInterval, type: ToastType, source: Source)
    /** The delegation from Trace for starting a trace */
    func startTrace(key: String, properties: [String: Any]?, source: Source)
    /** The delegation from Trace for incrementing a trace by name and a specific amount */
    func incrementTraceCounter(key: String, named: String, by count: Int, source: Source)
    /** The delegation from Trace for stopping a trace */
    func stopTrace(key: String, source: Source)
    /** The delegation from Network to notify the parent app that network activity has started */
    func networkActivityStarted(source: Source)
    /** The delegation from Network to notify the parent app that network activity has ended */
    func networkActivityEnded(source: Source)
}
