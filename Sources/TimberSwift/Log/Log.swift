import Foundation

public protocol LogProtocol {
    /**
     Helper method to implement default values in a protocol for file, function, line. Not intended to be used directly.
     */
    func log(_ message: String, errorType: TimberErrorType?, properties: [String: Any]?, _ file: String, _ function: String, _ line: Int, logLevel: LogLevel)
}

public extension LogProtocol {
    /**
     Logs with the log level of debug.
     - parameter message: The reason for the log
     - parameter properties: Supplementary key/value pairs for when more than a message is needed
     */
    func debug(_ message: String, properties: [String: Any]? = nil, _ file: String = #file, _ function: String = #function, _ line: Int = #line) { log(message, errorType: nil, properties: properties, file, function, line, logLevel: .debug) }
    
    /**
     Logs with the log level of info.
     - parameter message: The reason for the log
     - parameter properties: Supplementary key/value pairs for when more than a message is needed
     */
    func info(_ message: String, properties: [String: Any]? = nil, _ file: String = #file, _ function: String = #function, _ line: Int = #line) { log(message, errorType: nil, properties: properties, file, function, line, logLevel: .info) }
    
    /**
     Logs with the log level of warning.
     - parameter message: The reason for the log
     - parameter properties: Supplementary key/value pairs for when more than a message is needed
     */
    func warning(_ message: String, properties: [String: Any]? = nil, _ file: String = #file, _ function: String = #function, _ line: Int = #line) { log(message, errorType: nil, properties: properties, file, function, line, logLevel: .warning) }
    
    /**
     Logs with the log level of debug.
     - parameter message: The reason for the error
     - parameter errorType: The type of error and code to log
     - parameter properties: Supplementary error key/value pairs. The key is expected to be space seperated capitalized words.
     */
    func error(_ message: String, errorType: TimberErrorType, properties: [String: Any]? = nil, _ file: String = #file, _ function: String = #function, _ line: Int = #line) { log(message, errorType: errorType, properties: properties, file, function, line, logLevel: .error) }
}

internal protocol LogDelegate: class {
    func log(message: LogMessage)
    func log(error: TimberError)
}

internal class Log: LogProtocol {
    private let source: Source
    
    weak var logDelegate: LogDelegate?
    
    init(source: Source) {
        self.source = source
    }
    
    func log(_ message: String, errorType: TimberErrorType?, properties: [String: Any]? = nil, _ file: String, _ function: String, _ line: Int, logLevel: LogLevel) {
        let logMessage = LogMessage(message: message, logLevel: logLevel, source: source, file: file, function: function, line: line, properties: properties, errorType: errorType)
        
        logDelegate?.log(message: logMessage)
        
        if let errorType = errorType, logLevel == .error {
            logDelegate?.log(error: TimberError(logMessage: logMessage, errorType: errorType))
        }
    }
}
