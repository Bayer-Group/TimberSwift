import UIKit
import TimberSwift

final class AppSession {
    static let shared = AppSession()
    
    let timber: TimberProtocol
    private let source = Source(title: "Example Application", version: "1.2.3", emoji: Character("🌲"))
    
    private var currentNetworkCalls = 0 {
        didSet {
            DispatchQueue.main.async { [unowned self] in
                if self.currentNetworkCalls > 0 {
                    UIApplication.shared.isNetworkActivityIndicatorVisible = true
                } else {
                    UIApplication.shared.isNetworkActivityIndicatorVisible = false
                }
            }
        }
    }
    
    private init() {
        timber = Timber(source: source)
        Timber.timberApplicationDelegate = self
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
    
    func startTrace(key: String, properties: [String: Any]?, source: Source) {
        print("TRACE: Start performance trace key: \(key), properties: \(properties ?? [:]), source: \"\(source)\"")
    }
    
    func incrementTraceCounter(key: String, named: String, by count: Int, source: Source) {
        print("TRACE: Increment performance trace counter key: \(key), name: \(named), by: \(count), source: \"\(source)\"")
    }
    
    func stopTrace(key: String, source: Source) {
        print("TRACE: Stop performance trace key: \(key), source: \"\(source)\"")
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
