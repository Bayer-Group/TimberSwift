import UIKit
import TimberSwift

final class AppSession {
    static let shared = AppSession()
    
    let timber: TimberProtocol
    private let source = Source(title: "Example Application", version: "1.2.3", emoji: Character("🌲"))
    
    private var performanceTime: [String: Date] = [:]
    private let timer: DispatchSourceTimer
    
    private var currentNetworkCalls = 0 {
        didSet {
            DispatchQueue.main.async { [unowned self] in
                UIApplication.shared.isNetworkActivityIndicatorVisible = self.currentNetworkCalls > 0
            }
        }
    }
    
    private init() {
        timber = Timber(source: source)
        
        let performanceOvertimeCheckInSeconds: Double = 60
        let performanceOvertimeMaximumInSeconds: Double = 60 * 30
        
        let queue = DispatchQueue(label: "timber.performance.overtime.timer")
        timer = DispatchSource.makeTimerSource(queue: queue)
        timer.schedule(deadline: .now() + performanceOvertimeCheckInSeconds, repeating: performanceOvertimeCheckInSeconds, leeway: .seconds(0))
        timer.setEventHandler { [weak self] in
            let overtimeValues: [String]? = self?.performanceTime.compactMap {
                let secondsElapsed = Date().timeIntervalSince1970 - $0.value.timeIntervalSince1970
                return secondsElapsed > performanceOvertimeMaximumInSeconds ? $0.key : nil
            }
            overtimeValues?.forEach {
                self?.performanceTime[$0] = nil
            }
        }
        timer.resume()
        
        Timber.timberApplicationDelegate = self
    }
    
    deinit {
        timer.cancel()
    }
}

extension AppSession: TimberApplicationDelegate {
    func setScreen(title: String, source: Source) {
        print("SCREEN: Parent application handled the screen: \"\(title)\", source: \"\(source)\"")
    }
    
    func recordEvent(title: String, properties: [String: Any]?, source: Source) {
        print("EVENT: Parent application handled the event: \"\(title)\", properties: \(properties ?? [:]), source: \"\(source)\"")
    }
    
    func log(_ logMessage: LogMessage) {
        print("LOG: \"\(logMessage.consoleMessage)\", logLevel: \(logMessage.logLevel), source: \(logMessage.source)")
    }
    
    func log(_ error: TimberError) {
        print("ERROR: Parent application should pass the error to analytics: \"\(error.foundationError)\"")
    }
    
    func toast(_ message: String, displayTime: TimeInterval, type: ToastType, source: Source) {
        print("TOAST: Parent should display toast message: \"\(message)\", displayTime: \(displayTime), type: \(type), source: \"\(source)\"")
    }
    
    func startTrace(key: String, identifier: UUID?, properties: [String: Any]?, source: Source) {
        performanceTime[key.performanceTimeKey(identifier: identifier)] = Date()
        
        print("TRACE: Start performance trace key: \(key), identifier: \(identifier?.uuidString ?? ""), properties: \(properties ?? [:]), source: \"\(source)\"")
    }
    
    func incrementTraceCounter(key: String, identifier: UUID?, named: String, by count: Int, source: Source) {
        let startDate = performanceTime[key.performanceTimeKey(identifier: identifier)]
        let timeElapsed = Date().timeIntervalSince1970 - (startDate?.timeIntervalSince1970 ?? Date().timeIntervalSince1970)
        
        print("TRACE: Increment performance trace counter key: \(key), identifier: \(identifier?.uuidString ?? ""), name: \(named), by: \(count), timeElapsed: \(timeElapsed), source: \"\(source)\"")
    }
    
    func stopTrace(key: String, identifier: UUID?, source: Source) {
        let startDate = performanceTime.removeValue(forKey: key.performanceTimeKey(identifier: identifier))
        let timeElapsed = Date().timeIntervalSince1970 - (startDate?.timeIntervalSince1970 ?? Date().timeIntervalSince1970)
        
        print("TRACE: Stop performance trace key: \(key), identifier: \(identifier?.uuidString ?? ""), timeElapsed: \(timeElapsed), source: \"\(source)\"")
    }
    
    func networkActivityStarted(source: Source) {
        print("NETWORK: Activity started from source: \"\(source)\"")
        currentNetworkCalls += 1
    }
    
    func networkActivityEnded(source: Source) {
        print("NETWORK: Activity ended from source: \"\(source)\"")
        currentNetworkCalls -= 1
    }
}

fileprivate extension String {
    func performanceTimeKey(identifier: UUID?) -> String { identifier.flatMap { "\(self)|\($0.uuidString)" } ?? self }
}
