import Foundation

/**
 An Error class for storing information about an error logged in Timber.
 */
public struct TimberError: Error {
    /** The error message */
    public let logMessage: LogMessage
    /** The error type */
    public let errorType: TimberErrorType
    /** Properties associated with the log message and error */
    public let properties: [String: Any]
    
    init(logMessage: LogMessage, errorType: TimberErrorType) {
        var properties = logMessage.properties ?? [:]
        properties["Version"] = logMessage.source.version
        properties["File Name"] = logMessage.fileName
        properties["Function"] = logMessage.function
        properties["Line"] = logMessage.line
        
        errorType.properties.forEach { (key, value) in properties[key] = value }
        
        self.logMessage = logMessage
        self.errorType = errorType
        self.properties = properties
    }
    
    /**
     Produces an NSError from the information provided to TimberError for reporting to services such as Crashlytics
     */
    public var foundationError: NSError {
        var properties = self.properties
        properties[NSLocalizedDescriptionKey] = logMessage.message
        return NSError(domain: logMessage.source.title, code: errorType.code, userInfo: properties)
    }
}
