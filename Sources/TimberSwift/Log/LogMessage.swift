import Foundation

/**
 A LogMessage contains all collected information for logging
 - consoleMessage: Formatted for console display
 - fileName: The original file property reduced to just the name
 */
public struct LogMessage {
    public let message: String
    public let logLevel: LogLevel
    public let source: Source
    public let file: String
    public let function: String
    public let line: Int
    public let properties: [String: Any]?
    
    public var fileName: String {
        let fileNsString = ((file as NSString).lastPathComponent as NSString)
        return "\(fileNsString.deletingPathExtension).\(fileNsString.pathExtension)"
    }
    
    public var consoleMessage: String {
        var consoleMessage = "\(source.emoji) \(source.title) \(source.emoji): "
        consoleMessage += "\(fileName) [\(line)] \(function) "
        consoleMessage += "\(logLevel.emoji) "
        consoleMessage += errorType != nil ? "\(errorType!) - " : ""
        consoleMessage += "\(message) \(logLevel.emoji) "
        consoleMessage += properties != nil ? ", properties: \(properties!)": ""
        return consoleMessage
    }
    
    internal let errorType: TimberErrorType?
    
    internal init(message: String, logLevel: LogLevel, source: Source, file: String, function: String, line: Int, properties: [String: Any]? = nil, errorType: TimberErrorType? = nil) {
        self.message = message
        self.logLevel = logLevel
        self.source = source
        self.file = file
        self.function = function
        self.line = line
        self.properties = properties
        self.errorType = errorType
    }
}
