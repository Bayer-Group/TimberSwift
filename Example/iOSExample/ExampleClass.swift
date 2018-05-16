import TimberSwift

class ExampleClass {
    let log: LogProtocol
    let analytics: AnalyticsProtocol
    
    init(log: LogProtocol, analytics: AnalyticsProtocol) {
        self.log = log
        self.analytics = analytics
    }
    
    func actionTaken() {
        log.info("Action Taken")
        log.error("Error ocurred while parsing a service call response", errorType: .json, properties: ["Response": "{}"])
        log.error("Error occured while downloading stuff", errorType: .http(statusCode: 400), properties: ["Request": "I'm a bad request"])
    }
}
