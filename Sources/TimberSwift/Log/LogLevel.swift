public enum LogLevel: Int, Comparable, Hashable {
    case error = 1
    case warning
    case info
    case debug
    
    internal var analyticsName: String {
        switch self {
        case .error: return "error"
        case .warning: return "warning"
        case .info: return "info"
        case .debug: return "debug"
        }
    }
    
    internal var emoji: String {
        switch self {
        case .error: return "❤️"
        case .warning: return "💛"
        case .info: return "💚"
        case .debug: return "💙"
        }
    }
    
    public static func < (lhs: LogLevel, rhs: LogLevel) -> Bool { lhs.rawValue < rhs.rawValue }
}
