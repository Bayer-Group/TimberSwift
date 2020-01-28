import XCTest

@testable import TimberSwift

class TimberTests: XCTestCase {
    private var timber: Timber!
    
    private var mockAnaylitcs: MockAnalytics!
    private var mockLog: MockLog!
    private var mockUserMessage: MockUserMessage!
    private var mockPerformance: MockPerformance!
    private var mockNetwork: MockNetwork!
    
    override func setUp() {
        super.setUp()
        
        let source = Source(title: "Application 1", version: "1.0.0", emoji: "♳")
        mockAnaylitcs = .init()
        mockLog = .init()
        mockUserMessage = .init()
        mockPerformance = .init()
        mockNetwork = .init()
        
        timber = .init(source: source, analytics: mockAnaylitcs, log: mockLog, userMessage: mockUserMessage, performance: mockPerformance, network: mockNetwork)
    }
    
    func testAnalytics() {
        timber.analytics.setScreen(title: "title")
        XCTAssertEqual(mockAnaylitcs.stub.setScreenCallCount, 1)
        XCTAssertEqual(mockAnaylitcs.stub.setScreenCalledWith, ["title"])
        
        timber.analytics.recordEvent(title: "title", properties: ["key": "value"])
        XCTAssertEqual(mockAnaylitcs.stub.recordEventCallCount, 1)
        XCTAssertEqual(mockAnaylitcs.stub.recordEventCalledWith.first?.title, "title")
        XCTAssertEqual(mockAnaylitcs.stub.recordEventCalledWith.first?.properties?.count, 1)
        XCTAssertEqual(mockAnaylitcs.stub.recordEventCalledWith.first?.properties?.first!.key, "key")
        XCTAssertEqual(mockAnaylitcs.stub.recordEventCalledWith.first?.properties?.first!.value as? String, "value")
    }
    
    // swiftlint:disable:next function_body_length
    func testLog() {
        let fileName = "TimberTests.swift"
        let function = "testLog()"
        
        let infoLine = #line; timber.log.info("info", properties: ["infoKey": "infoValue"])
        let debugLine = #line; timber.log.debug("debug", properties: ["debugKey": "debugValue"])
        let warningLine = #line; timber.log.warning("warning", properties: ["warningKey": "warningValue"])
        let errorLine = #line; timber.log.error("error", errorType: .internal, properties: ["errorKey": "errorValue"])
        
        XCTAssertEqual(mockLog.stub.logCallCount, 4)
        XCTAssertEqual(mockLog.stub.logCalledWith.at(0)?.message, "info")
        XCTAssertEqual(mockLog.stub.logCalledWith.at(0)?.errorType, nil)
        XCTAssertEqual(mockLog.stub.logCalledWith.at(0)?.logLevel, .info)
        XCTAssertTrue(mockLog.stub.logCalledWith.at(0)?.file.contains(fileName) ?? false)
        XCTAssertEqual(mockLog.stub.logCalledWith.at(0)?.function, function)
        XCTAssertEqual(mockLog.stub.logCalledWith.at(0)?.line, infoLine)
        XCTAssertEqual(mockLog.stub.logCalledWith.at(0)?.properties?.count, 1)
        XCTAssertEqual(mockLog.stub.logCalledWith.at(0)?.properties?.first!.key, "infoKey")
        XCTAssertEqual(mockLog.stub.logCalledWith.at(0)?.properties?.first!.value as? String, "infoValue")
        XCTAssertEqual(mockLog.stub.logCalledWith.at(1)?.message, "debug")
        XCTAssertEqual(mockLog.stub.logCalledWith.at(1)?.errorType, nil)
        XCTAssertEqual(mockLog.stub.logCalledWith.at(1)?.logLevel, .debug)
        XCTAssertTrue(mockLog.stub.logCalledWith.at(1)?.file.contains(fileName) ?? false)
        XCTAssertEqual(mockLog.stub.logCalledWith.at(1)?.function, function)
        XCTAssertEqual(mockLog.stub.logCalledWith.at(1)?.line, debugLine)
        XCTAssertEqual(mockLog.stub.logCalledWith.at(1)?.properties?.count, 1)
        XCTAssertEqual(mockLog.stub.logCalledWith.at(1)?.properties?.first!.key, "debugKey")
        XCTAssertEqual(mockLog.stub.logCalledWith.at(1)?.properties?.first!.value as? String, "debugValue")
        XCTAssertEqual(mockLog.stub.logCalledWith.at(2)?.message, "warning")
        XCTAssertEqual(mockLog.stub.logCalledWith.at(2)?.errorType, nil)
        XCTAssertEqual(mockLog.stub.logCalledWith.at(2)?.logLevel, .warning)
        XCTAssertTrue(mockLog.stub.logCalledWith.at(2)?.file.contains(fileName) ?? false)
        XCTAssertEqual(mockLog.stub.logCalledWith.at(2)?.function, function)
        XCTAssertEqual(mockLog.stub.logCalledWith.at(2)?.line, warningLine)
        XCTAssertEqual(mockLog.stub.logCalledWith.at(2)?.properties?.count, 1)
        XCTAssertEqual(mockLog.stub.logCalledWith.at(2)?.properties?.first!.key, "warningKey")
        XCTAssertEqual(mockLog.stub.logCalledWith.at(2)?.properties?.first!.value as? String, "warningValue")
        XCTAssertEqual(mockLog.stub.logCalledWith.at(3)?.message, "error")
        XCTAssertEqual(mockLog.stub.logCalledWith.at(3)?.errorType, .internal)
        XCTAssertEqual(mockLog.stub.logCalledWith.at(3)?.logLevel, .error)
        XCTAssertTrue(mockLog.stub.logCalledWith.at(3)?.file.contains(fileName) ?? false)
        XCTAssertEqual(mockLog.stub.logCalledWith.at(3)?.function, function)
        XCTAssertEqual(mockLog.stub.logCalledWith.at(3)?.line, errorLine)
        XCTAssertEqual(mockLog.stub.logCalledWith.at(3)?.properties?.count, 1)
        XCTAssertEqual(mockLog.stub.logCalledWith.at(3)?.properties?.first!.key, "errorKey")
        XCTAssertEqual(mockLog.stub.logCalledWith.at(3)?.properties?.first!.value as? String, "errorValue")
    }
    
    func testUserMessage() {
        timber.userMessage.toast("none", displayTime: 1, type: .none)
        timber.userMessage.toast("success", displayTime: 2, type: .success)
        timber.userMessage.toast("failure", displayTime: 3, type: .failure)
        
        XCTAssertEqual(mockUserMessage.stub.toastCallCount, 3)
        XCTAssertEqual(mockUserMessage.stub.toastCalledWith.at(0)?.message, "none")
        XCTAssertEqual(mockUserMessage.stub.toastCalledWith.at(0)?.displayTime, 1)
        XCTAssertEqual(mockUserMessage.stub.toastCalledWith.at(0)?.type, ToastType.none)
        XCTAssertEqual(mockUserMessage.stub.toastCalledWith.at(1)?.message, "success")
        XCTAssertEqual(mockUserMessage.stub.toastCalledWith.at(1)?.displayTime, 2)
        XCTAssertEqual(mockUserMessage.stub.toastCalledWith.at(1)?.type, .success)
        XCTAssertEqual(mockUserMessage.stub.toastCalledWith.at(2)?.message, "failure")
        XCTAssertEqual(mockUserMessage.stub.toastCalledWith.at(2)?.displayTime, 3)
        XCTAssertEqual(mockUserMessage.stub.toastCalledWith.at(2)?.type, .failure)
    }
    
    func testPerformance() {
        let startUUID = UUID()
        let incrementUUID = UUID()
        let stopUUID = UUID()
        
        timber.performance.startTrace(key: "startKey", identifier: startUUID, properties: ["key": "value"])
        timber.performance.incrementTraceCounter(key: "incrementKey", identifier: incrementUUID, named: "named", by: 1)
        timber.performance.stopTrace(key: "stopKey", identifier: stopUUID)
        
        XCTAssertEqual(mockPerformance.stub.startTraceCallCount, 1)
        XCTAssertEqual(mockPerformance.stub.startTraceCalledWith.first?.key, "startKey")
        XCTAssertEqual(mockPerformance.stub.startTraceCalledWith.first?.identifier, startUUID)
        XCTAssertEqual(mockPerformance.stub.startTraceCalledWith.first?.properties?.count, 1)
        XCTAssertEqual(mockPerformance.stub.startTraceCalledWith.first?.properties?.first!.key, "key")
        XCTAssertEqual(mockPerformance.stub.startTraceCalledWith.first?.properties?.first!.value as? String, "value")
        XCTAssertEqual(mockPerformance.stub.incrementTraceCounterCallCount, 1)
        XCTAssertEqual(mockPerformance.stub.incrementTraceCounterCalledWith.first?.key, "incrementKey")
        XCTAssertEqual(mockPerformance.stub.incrementTraceCounterCalledWith.first?.identifier, incrementUUID)
        XCTAssertEqual(mockPerformance.stub.incrementTraceCounterCalledWith.first?.named, "named")
        XCTAssertEqual(mockPerformance.stub.incrementTraceCounterCalledWith.first?.count, 1)
        XCTAssertEqual(mockPerformance.stub.stopTraceCallCount, 1)
        XCTAssertEqual(mockPerformance.stub.stopTraceCalledWith.first?.key, "stopKey")
        XCTAssertEqual(mockPerformance.stub.stopTraceCalledWith.first?.identifier, stopUUID)
    }
    
    func testNetwork() {
        timber.network.startedActivity()
        XCTAssertEqual(mockNetwork.stub.startedActivityCallCount, 1)
        
        timber.network.endedActivity()
        XCTAssertEqual(mockNetwork.stub.endedActivityCallCount, 1)
    }
}
