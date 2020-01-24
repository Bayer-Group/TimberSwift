public protocol AnalyticsProtocol {
    /**
     Analytics screen title to be used when a user has viewed a screen
     
     - parameter title: Screen title with expected format of space seperated capitalized words.
     */
    func setScreen(title: String)
    
    /**
     Analytics events to be logged
     
     - parameter title: Event title with expected format of space seperate capitalized words.
     - parameter properties: Supplementary key/value event information pairs. The key is expected to be space seperated capitalized words.
     */
    func recordEvent(title: String, properties: [String: Any]?)
}

internal protocol AnalyticsDelegate: class {
    func setScreen(title: String)
    func recordEvent(title: String, properties: [String: Any]?)
}

internal class Analytics: AnalyticsProtocol {
    weak var analyticsDelegate: AnalyticsDelegate?
    
    func setScreen(title: String) { analyticsDelegate?.setScreen(title: title) }
    
    func recordEvent(title: String, properties: [String: Any]?) { analyticsDelegate?.recordEvent(title: title, properties: properties) }
}
