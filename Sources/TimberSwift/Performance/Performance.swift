public protocol PerformanceProtocol {
    /**
     Start a performance trace which is intended to measure the time between start and stop
     - parameter title: The title with expected format of space seperated capitalized words.
     - parameter properties: Supplementary trace key/value pairs. The key is expected to be space seperated capitalized words.
     */
    func startTrace(key: String, properties: [String: Any]?)
    
    /**
     Increment a performance trace by increment name and amount
     - parameter key: The key of the trace
     - parameter named: The name of the increment
     - parameter count: The amount to increment
     */
    func incrementTraceCounter(key: String, named: String, by count: Int)
    
    /**
     Stop a performance trace
     - parameter title: The title with expected format of space seperated capitalized words.
     */
    func stopTrace(key: String)
}

internal protocol PerformanceDelegate: class {
    func startTrace(key: String, properties: [String: Any]?)
    func incrementTraceCounter(key: String, named: String, by count: Int)
    func stopTrace(key: String)
}

internal class Performance: PerformanceProtocol {
    weak var performanceDelegate: PerformanceDelegate?
    
    func startTrace(key: String, properties: [String: Any]?) {
        performanceDelegate?.startTrace(key: key, properties: properties)
    }
    
    func incrementTraceCounter(key: String, named: String, by count: Int) {
        performanceDelegate?.incrementTraceCounter(key: key, named: named, by: count)
    }
    
    func stopTrace(key: String) {
        performanceDelegate?.stopTrace(key: key)
    }
}
