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

public extension PerformanceProtocol {
    @available(*, deprecated, message: "A UUID Identifier is now part of the signature and this will be removed in a future version")
    func startTrace(key: String, properties: [String: Any]?) { startTrace(key: key, identifier: nil, properties: properties) }
    
    @available(*, deprecated, message: "A UUID Identifier is now part of the signature and this will be removed in a future version")
    func incrementTraceCounter(key: String, named: String, by count: Int) { incrementTraceCounter(key: key, identifier: nil, named: named, by: count) }
    
    @available(*, deprecated, message: "A UUID Identifier is now part of the signature and this will be removed in a future version")
    func stopTrace(key: String) { stopTrace(key: key, identifier: nil) }
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
