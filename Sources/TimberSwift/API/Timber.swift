import Foundation

public protocol TimberProtocol {
    /** The source for this instance of Timber */
    var source: Source { get }
    
    /** Analytics functions */
    var analytics: AnalyticsProtocol { get }
    /** Logging functions */
    var log: LogProtocol { get }
    /** User messaging functions such as toasting */
    var userMessage: UserMessageProtocol { get }
    /** Performance functions for tracking the time from start to stop */
    var performance: PerformanceProtocol { get }
    /** Functions to track network activity */
    var network: NetworkProtocol { get }
}

public final class Timber: TimberProtocol {
    /** The source for this instance of Timber */
    public let source: Source
    
    /** Analytics functions */
    public let analytics: AnalyticsProtocol
    /** Logging functions */
    public let log: LogProtocol
    /** User messaging functions such as toasting */
    public let userMessage: UserMessageProtocol
    /** Performance functions for tracking the time from start to stop */
    public let performance: PerformanceProtocol
    /** Functions to track network activity */
    public let network: NetworkProtocol
    
    /** Intended to be from the parent application to act on all activity from frameworks and the parent application itself */
    public static weak var timberApplicationDelegate: TimberApplicationDelegate?
    
    /**
     - parameter source: The framework or application source
     */
    public init(source: Source) {
        let analytics = Analytics()
        let log = Log(source: source)
        let userMessage = UserMessage()
        let performance = Performance()
        let network = Network()
        
        self.source = source
        self.analytics = analytics
        self.log = log
        self.userMessage = userMessage
        self.performance = performance
        self.network = network
        
        analytics.analyticsDelegate = self
        log.logDelegate = self
        userMessage.userMessageDelegate = self
        performance.performanceDelegate = self
        network.networkDelegate = self
    }
}

extension Timber: LogDelegate {
    func log(_ logMessage: LogMessage) {
        Timber.timberApplicationDelegate?.log(logMessage)
    }
    
    func log(_ error: TimberError) {
        Timber.timberApplicationDelegate?.log(error)
    }
}

extension Timber: AnalyticsDelegate {
    func setScreen(title: String) {
        Timber.timberApplicationDelegate?.setScreen(title: title, source: source)
    }
    
    func recordEvent(title: String, properties: [String: Any]?) {
        Timber.timberApplicationDelegate?.recordEvent(title: title, properties: properties, source: source)
    }
}

extension Timber: UserMessageDelegate {
    func toast(_ message: String, displayTime: TimeInterval, type: ToastType) {
        Timber.timberApplicationDelegate?.toast(message, displayTime: displayTime, type: type, source: source)
    }
}

extension Timber: PerformanceDelegate {
    func startTrace(key: String, identifier: UUID?, properties: [String: Any]?) {
        Timber.timberApplicationDelegate?.startTrace(key: key, identifier: identifier, properties: properties, source: source)
    }
    
    func incrementTraceCounter(key: String, identifier: UUID?, named: String, by count: Int) {
        Timber.timberApplicationDelegate?.incrementTraceCounter(key: key, identifier: identifier, named: named, by: count, source: source)
    }
    
    func stopTrace(key: String, identifier: UUID?) {
        Timber.timberApplicationDelegate?.stopTrace(key: key, identifier: identifier, source: source)
    }
}

extension Timber: NetworkDelegate {
    func startedActivity() {
        Timber.timberApplicationDelegate?.networkActivityStarted(source: source)
    }
    
    func endedActivity() {
        Timber.timberApplicationDelegate?.networkActivityEnded(source: source)
    }
}
