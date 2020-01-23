import Foundation

public protocol PerformanceProtocol {
    /**
     Start a performance trace which is intended to measure the time between start and stop
     - parameter title: The title with expected format of space seperated capitalized words.
     - parameter identifier: The unique identifier for this trace.
     - parameter properties: Supplementary trace key/value pairs. The key is expected to be space seperated capitalized words.
     */
    func startTrace(key: String, identifier: UUID?, properties: [String: Any]?)
    
    /**
     Increment a performance trace by increment name and amount
     - parameter key: The key of the trace
     - parameter identifier: The unique identifier for this trace.
     - parameter named: The name of the increment
     - parameter count: The amount to increment
     */
    func incrementTraceCounter(key: String, identifier: UUID?, named: String, by count: Int)
    
    /**
     Stop a performance trace
     - parameter title: The title with expected format of space seperated capitalized words.
     - parameter identifier: The unique identifier for this trace.
     */
    func stopTrace(key: String, identifier: UUID?)
}

internal protocol PerformanceDelegate: class {
    func startTrace(key: String, identifier: UUID?, properties: [String: Any]?)
    func incrementTraceCounter(key: String, identifier: UUID?, named: String, by count: Int)
    func stopTrace(key: String, identifier: UUID?)
}

internal class Performance: PerformanceProtocol {
    weak var performanceDelegate: PerformanceDelegate?
    
    func startTrace(key: String, identifier: UUID?, properties: [String: Any]?) { performanceDelegate?.startTrace(key: key, identifier: identifier, properties: properties) }
    
    func incrementTraceCounter(key: String, identifier: UUID?, named: String, by count: Int) { performanceDelegate?.incrementTraceCounter(key: key, identifier: identifier, named: named, by: count) }
    
    func stopTrace(key: String, identifier: UUID?) { performanceDelegate?.stopTrace(key: key, identifier: identifier) }
}
