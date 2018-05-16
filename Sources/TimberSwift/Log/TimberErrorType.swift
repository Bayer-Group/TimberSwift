/**
 The type of error as logged in Timber.
 */
public enum TimberErrorType: CustomStringConvertible, Equatable {
    case authentication
    case network
    case http(statusCode: Int)
    case json
    case file
    case persistence
    case `internal`
    case user
    case device
    case other
    
    /** The error code as used by services such as Crashlytics */
    public var code: Int {
        switch self {
        case .authentication: return 10
        case .network: return 20
        case .http: return 30
        case .json: return 40
        case .file: return 50
        case .persistence: return 60
        case .`internal`: return 70
        case .user: return 80
        case .device: return 90
        case .other: return 999
        }
    }
    
    /** The general title of the error type */
    public var title: String {
        switch self {
        case .authentication: return "Authentication"
        case .network: return "Network"
        case .http: return "HTTP"
        case .json: return "JSON"
        case .file: return "File"
        case .persistence: return "Persistence"
        case .`internal`: return "Internal"
        case .user: return "User"
        case .device: return "Device"
        case .other: return "Other"
        }
    }
    
    /** A general desciption of the error type */
    public var description: String {
        let baseDescription = "\(title) Error (\(code))"
        switch self {
        case .http(let statusCode): return baseDescription + " - Status Code \(statusCode)"
        default: return baseDescription
        }
    }
    
    /** Properties to be added creating the error */
    public var properties: [String: Any] {
        var properties: [String: Any] = ["Error Code": code, "Error Description": description]
        if case let .http(statusCode) = self {
            properties["HTTP Status Code"] = statusCode
        }
        return properties
    }
    
    public static func == (lhs: TimberErrorType, rhs: TimberErrorType) -> Bool {
        if case let .http(lhsStatus) = lhs, case let .http(rhsStatus) = rhs {
            return lhsStatus == rhsStatus
        }
        return lhs.code == rhs.code
    }
}
