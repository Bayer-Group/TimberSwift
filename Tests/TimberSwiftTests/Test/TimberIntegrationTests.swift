import XCTest

@testable import TimberSwift

// swiftlint:disable:next type_body_length
class TimberIntegrationTests: XCTestCase {
    private var timberApplication1: Timber!
    private var timberApplication2: Timber!
    
    // swiftlint:disable:next weak_delegate
    private var mockTimberApplicationDelegate: MockTimberApplicationDelegate!
    
    let application1Source = Source(title: "Application 1", version: "1.0.0", emoji: "♳")
    
    let application2Source = Source(title: "Application 2", version: "2.2.2", emoji: "♴")
    
    override func setUp() {
        super.setUp()
        
        timberApplication1 = .init(source: application1Source)
        timberApplication2 = .init(source: application2Source)
        
        mockTimberApplicationDelegate = MockTimberApplicationDelegate()
        
        Timber.timberApplicationDelegate = mockTimberApplicationDelegate
    }
    
    func testAnalytics() {
        timberApplication1.analytics.setScreen(title: "screen1")
        timberApplication2.analytics.setScreen(title: "screen2")
        
        XCTAssertEqual(mockTimberApplicationDelegate.stub.setScreenCallCount, 2)
        XCTAssertEqual(mockTimberApplicationDelegate.stub.setScreenCalledWith.at(0)?.title, "screen1")
        XCTAssertEqual(mockTimberApplicationDelegate.stub.setScreenCalledWith.at(0)?.source, application1Source)
        XCTAssertEqual(mockTimberApplicationDelegate.stub.setScreenCalledWith.at(1)?.title, "screen2")
        XCTAssertEqual(mockTimberApplicationDelegate.stub.setScreenCalledWith.at(1)?.source, application2Source)
        
        timberApplication1.analytics.recordEvent(title: "title1", properties: ["key1": "value1"])
        timberApplication2.analytics.recordEvent(title: "title2", properties: ["key2": "value2"])
        
        XCTAssertEqual(mockTimberApplicationDelegate.stub.recordEventCallCount, 2)
        XCTAssertEqual(mockTimberApplicationDelegate.stub.recordEventCalledWith.at(0)?.title, "title1")
        XCTAssertEqual(mockTimberApplicationDelegate.stub.recordEventCalledWith.at(0)?.source, application1Source)
        XCTAssertEqual(mockTimberApplicationDelegate.stub.recordEventCalledWith.at(0)?.properties?.count, 1)
        XCTAssertEqual(mockTimberApplicationDelegate.stub.recordEventCalledWith.at(0)?.properties?.first!.key, "key1")
        XCTAssertEqual(mockTimberApplicationDelegate.stub.recordEventCalledWith.at(0)?.properties?.first!.value as? String, "value1")
        XCTAssertEqual(mockTimberApplicationDelegate.stub.recordEventCalledWith.at(1)?.title, "title2")
        XCTAssertEqual(mockTimberApplicationDelegate.stub.recordEventCalledWith.at(1)?.source, application2Source)
        XCTAssertEqual(mockTimberApplicationDelegate.stub.recordEventCalledWith.at(1)?.properties?.count, 1)
        XCTAssertEqual(mockTimberApplicationDelegate.stub.recordEventCalledWith.at(1)?.properties?.first!.key, "key2")
        XCTAssertEqual(mockTimberApplicationDelegate.stub.recordEventCalledWith.at(1)?.properties?.first!.value as? String, "value2")
    }
    
    // swiftlint:disable:next function_body_length
    func testLog() {
        let fileName = "TimberIntegrationTests.swift"
        let functionName = "testLog()"
        let timberApplication1InfoLine = #line; timberApplication1.log.info("info1", properties: ["infoKey1": "infoValue1"])
        let timberApplication1DebugLine = #line; timberApplication1.log.debug("debug1", properties: ["debugKey1": "debugValue1"])
        let timberApplication1WarningLine = #line; timberApplication1.log.warning("warning1", properties: ["warningKey1": "warningValue1"])
        let timberApplication1ErrorLine = #line; timberApplication1.log.error("error1", errorType: .internal, properties: ["errorKey1": "errorValue1"])
        
        let timberApplication2InfoLine = #line; timberApplication2.log.info("info2", properties: ["infoKey2": "infoValue2"])
        let timberApplication2DebugLine = #line; timberApplication2.log.debug("debug2", properties: ["debugKey2": "debugValue2"])
        let timberApplication2WarningLine = #line; timberApplication2.log.warning("warning2", properties: ["warningKey2": "warningValue2"])
        let timberApplication2ErrorLine = #line; timberApplication2.log.error("error2", errorType: .other, properties: ["errorKey2": "errorValue2"])
        
        XCTAssertEqual(mockTimberApplicationDelegate.stub.logMessageCallCount, 8)
        XCTAssertEqual(mockTimberApplicationDelegate.stub.logErrorCallCount, 2)
        
        XCTAssertEqual(mockTimberApplicationDelegate.stub.logMessageCalledWith.at(0)?.message, "info1")
        XCTAssertEqual(mockTimberApplicationDelegate.stub.logMessageCalledWith.at(0)?.logLevel, .info)
        XCTAssertEqual(mockTimberApplicationDelegate.stub.logMessageCalledWith.at(0)?.consoleMessage, "\(application1Source.emoji) \(application1Source.title) \(application1Source.emoji): \(fileName) [\(timberApplication1InfoLine)] \(functionName) \(LogLevel.info.emoji) info1 \(LogLevel.info.emoji) , properties: [\"infoKey1\": \"infoValue1\"]")
        XCTAssertEqual(mockTimberApplicationDelegate.stub.logMessageCalledWith.at(0)?.source, application1Source)
        XCTAssertTrue(mockTimberApplicationDelegate.stub.logMessageCalledWith.at(0)?.file.contains(fileName) ?? false)
        XCTAssertEqual(mockTimberApplicationDelegate.stub.logMessageCalledWith.at(0)?.function, functionName)
        XCTAssertEqual(mockTimberApplicationDelegate.stub.logMessageCalledWith.at(0)?.line, timberApplication1InfoLine)
        XCTAssertEqual(mockTimberApplicationDelegate.stub.logMessageCalledWith.at(0)?.properties?.count, 1)
        XCTAssertEqual(mockTimberApplicationDelegate.stub.logMessageCalledWith.at(0)?.properties?.first?.key, "infoKey1")
        XCTAssertEqual(mockTimberApplicationDelegate.stub.logMessageCalledWith.at(0)?.properties?.first?.value as? String, "infoValue1")
        XCTAssertEqual(mockTimberApplicationDelegate.stub.logMessageCalledWith.at(1)?.message, "debug1")
        XCTAssertEqual(mockTimberApplicationDelegate.stub.logMessageCalledWith.at(1)?.logLevel, .debug)
        XCTAssertEqual(mockTimberApplicationDelegate.stub.logMessageCalledWith.at(1)?.consoleMessage, "\(application1Source.emoji) \(application1Source.title) \(application1Source.emoji): \(fileName) [\(timberApplication1DebugLine)] \(functionName) \(LogLevel.debug.emoji) debug1 \(LogLevel.debug.emoji) , properties: [\"debugKey1\": \"debugValue1\"]")
        XCTAssertEqual(mockTimberApplicationDelegate.stub.logMessageCalledWith.at(1)?.source, application1Source)
        XCTAssertTrue(mockTimberApplicationDelegate.stub.logMessageCalledWith.at(1)?.file.contains(fileName) ?? false)
        XCTAssertEqual(mockTimberApplicationDelegate.stub.logMessageCalledWith.at(1)?.function, functionName)
        XCTAssertEqual(mockTimberApplicationDelegate.stub.logMessageCalledWith.at(1)?.line, timberApplication1DebugLine)
        XCTAssertEqual(mockTimberApplicationDelegate.stub.logMessageCalledWith.at(1)?.properties?.count, 1)
        XCTAssertEqual(mockTimberApplicationDelegate.stub.logMessageCalledWith.at(1)?.properties?.first?.key, "debugKey1")
        XCTAssertEqual(mockTimberApplicationDelegate.stub.logMessageCalledWith.at(1)?.properties?.first?.value as? String, "debugValue1")
        XCTAssertEqual(mockTimberApplicationDelegate.stub.logMessageCalledWith.at(2)?.message, "warning1")
        XCTAssertEqual(mockTimberApplicationDelegate.stub.logMessageCalledWith.at(2)?.logLevel, .warning)
        XCTAssertEqual(mockTimberApplicationDelegate.stub.logMessageCalledWith.at(2)?.consoleMessage, "\(application1Source.emoji) \(application1Source.title) \(application1Source.emoji): \(fileName) [\(timberApplication1WarningLine)] \(functionName) \(LogLevel.warning.emoji) warning1 \(LogLevel.warning.emoji) , properties: [\"warningKey1\": \"warningValue1\"]")
        XCTAssertEqual(mockTimberApplicationDelegate.stub.logMessageCalledWith.at(2)?.source, application1Source)
        XCTAssertTrue(mockTimberApplicationDelegate.stub.logMessageCalledWith.at(2)?.file.contains(fileName) ?? false)
        XCTAssertEqual(mockTimberApplicationDelegate.stub.logMessageCalledWith.at(2)?.function, functionName)
        XCTAssertEqual(mockTimberApplicationDelegate.stub.logMessageCalledWith.at(2)?.line, timberApplication1WarningLine)
        XCTAssertEqual(mockTimberApplicationDelegate.stub.logMessageCalledWith.at(2)?.properties?.count, 1)
        XCTAssertEqual(mockTimberApplicationDelegate.stub.logMessageCalledWith.at(2)?.properties?.first?.key, "warningKey1")
        XCTAssertEqual(mockTimberApplicationDelegate.stub.logMessageCalledWith.at(2)?.properties?.first?.value as? String, "warningValue1")
        XCTAssertEqual(mockTimberApplicationDelegate.stub.logMessageCalledWith.at(3)?.message, "error1")
        XCTAssertEqual(mockTimberApplicationDelegate.stub.logMessageCalledWith.at(3)?.logLevel, .error)
        XCTAssertEqual(mockTimberApplicationDelegate.stub.logMessageCalledWith.at(3)?.consoleMessage, "\(application1Source.emoji) \(application1Source.title) \(application1Source.emoji): \(fileName) [\(timberApplication1ErrorLine)] \(functionName) \(LogLevel.error.emoji) \(TimberErrorType.internal.description) - error1 \(LogLevel.error.emoji) , properties: [\"errorKey1\": \"errorValue1\"]")
        XCTAssertEqual(mockTimberApplicationDelegate.stub.logMessageCalledWith.at(3)?.source, application1Source)
        XCTAssertTrue(mockTimberApplicationDelegate.stub.logMessageCalledWith.at(3)?.file.contains(fileName) ?? false)
        XCTAssertEqual(mockTimberApplicationDelegate.stub.logMessageCalledWith.at(3)?.function, functionName)
        XCTAssertEqual(mockTimberApplicationDelegate.stub.logMessageCalledWith.at(3)?.line, timberApplication1ErrorLine)
        XCTAssertEqual(mockTimberApplicationDelegate.stub.logMessageCalledWith.at(3)?.properties?.count, 1)
        XCTAssertEqual(mockTimberApplicationDelegate.stub.logMessageCalledWith.at(3)?.properties?.first?.key, "errorKey1")
        XCTAssertEqual(mockTimberApplicationDelegate.stub.logMessageCalledWith.at(3)?.properties?.first?.value as? String, "errorValue1")
        XCTAssertEqual(mockTimberApplicationDelegate.stub.logMessageCalledWith.at(4)?.message, "info2")
        XCTAssertEqual(mockTimberApplicationDelegate.stub.logMessageCalledWith.at(4)?.logLevel, .info)
        XCTAssertEqual(mockTimberApplicationDelegate.stub.logMessageCalledWith.at(4)?.consoleMessage, "\(application2Source.emoji) \(application2Source.title) \(application2Source.emoji): \(fileName) [\(timberApplication2InfoLine)] \(functionName) \(LogLevel.info.emoji) info2 \(LogLevel.info.emoji) , properties: [\"infoKey2\": \"infoValue2\"]")
        XCTAssertEqual(mockTimberApplicationDelegate.stub.logMessageCalledWith.at(4)?.source, application2Source)
        XCTAssertTrue(mockTimberApplicationDelegate.stub.logMessageCalledWith.at(4)?.file.contains(fileName) ?? false)
        XCTAssertEqual(mockTimberApplicationDelegate.stub.logMessageCalledWith.at(4)?.function, functionName)
        XCTAssertEqual(mockTimberApplicationDelegate.stub.logMessageCalledWith.at(4)?.line, timberApplication2InfoLine)
        XCTAssertEqual(mockTimberApplicationDelegate.stub.logMessageCalledWith.at(4)?.properties?.count, 1)
        XCTAssertEqual(mockTimberApplicationDelegate.stub.logMessageCalledWith.at(4)?.properties?.first?.key, "infoKey2")
        XCTAssertEqual(mockTimberApplicationDelegate.stub.logMessageCalledWith.at(4)?.properties?.first?.value as? String, "infoValue2")
        XCTAssertEqual(mockTimberApplicationDelegate.stub.logMessageCalledWith.at(5)?.message, "debug2")
        XCTAssertEqual(mockTimberApplicationDelegate.stub.logMessageCalledWith.at(5)?.logLevel, .debug)
        XCTAssertEqual(mockTimberApplicationDelegate.stub.logMessageCalledWith.at(5)?.consoleMessage, "\(application2Source.emoji) \(application2Source.title) \(application2Source.emoji): \(fileName) [\(timberApplication2DebugLine)] \(functionName) \(LogLevel.debug.emoji) debug2 \(LogLevel.debug.emoji) , properties: [\"debugKey2\": \"debugValue2\"]")
        XCTAssertEqual(mockTimberApplicationDelegate.stub.logMessageCalledWith.at(5)?.source, application2Source)
        XCTAssertTrue(mockTimberApplicationDelegate.stub.logMessageCalledWith.at(5)?.file.contains(fileName) ?? false)
        XCTAssertEqual(mockTimberApplicationDelegate.stub.logMessageCalledWith.at(5)?.function, functionName)
        XCTAssertEqual(mockTimberApplicationDelegate.stub.logMessageCalledWith.at(5)?.line, timberApplication2DebugLine)
        XCTAssertEqual(mockTimberApplicationDelegate.stub.logMessageCalledWith.at(5)?.properties?.count, 1)
        XCTAssertEqual(mockTimberApplicationDelegate.stub.logMessageCalledWith.at(5)?.properties?.first?.key, "debugKey2")
        XCTAssertEqual(mockTimberApplicationDelegate.stub.logMessageCalledWith.at(5)?.properties?.first?.value as? String, "debugValue2")
        XCTAssertEqual(mockTimberApplicationDelegate.stub.logMessageCalledWith.at(6)?.message, "warning2")
        XCTAssertEqual(mockTimberApplicationDelegate.stub.logMessageCalledWith.at(6)?.logLevel, .warning)
        XCTAssertEqual(mockTimberApplicationDelegate.stub.logMessageCalledWith.at(6)?.consoleMessage, "\(application2Source.emoji) \(application2Source.title) \(application2Source.emoji): \(fileName) [\(timberApplication2WarningLine)] \(functionName) \(LogLevel.warning.emoji) warning2 \(LogLevel.warning.emoji) , properties: [\"warningKey2\": \"warningValue2\"]")
        XCTAssertEqual(mockTimberApplicationDelegate.stub.logMessageCalledWith.at(6)?.source, application2Source)
        XCTAssertTrue(mockTimberApplicationDelegate.stub.logMessageCalledWith.at(6)?.file.contains(fileName) ?? false)
        XCTAssertEqual(mockTimberApplicationDelegate.stub.logMessageCalledWith.at(6)?.function, functionName)
        XCTAssertEqual(mockTimberApplicationDelegate.stub.logMessageCalledWith.at(6)?.line, timberApplication2WarningLine)
        XCTAssertEqual(mockTimberApplicationDelegate.stub.logMessageCalledWith.at(6)?.properties?.count, 1)
        XCTAssertEqual(mockTimberApplicationDelegate.stub.logMessageCalledWith.at(6)?.properties?.first?.key, "warningKey2")
        XCTAssertEqual(mockTimberApplicationDelegate.stub.logMessageCalledWith.at(6)?.properties?.first?.value as? String, "warningValue2")
        XCTAssertEqual(mockTimberApplicationDelegate.stub.logMessageCalledWith.at(7)?.message, "error2")
        XCTAssertEqual(mockTimberApplicationDelegate.stub.logMessageCalledWith.at(7)?.logLevel, .error)
        XCTAssertEqual(mockTimberApplicationDelegate.stub.logMessageCalledWith.at(7)?.consoleMessage, "\(application2Source.emoji) \(application2Source.title) \(application2Source.emoji): \(fileName) [\(timberApplication2ErrorLine)] \(functionName) \(LogLevel.error.emoji) \(TimberErrorType.other.description) - error2 \(LogLevel.error.emoji) , properties: [\"errorKey2\": \"errorValue2\"]")
        XCTAssertEqual(mockTimberApplicationDelegate.stub.logMessageCalledWith.at(7)?.source, application2Source)
        XCTAssertTrue(mockTimberApplicationDelegate.stub.logMessageCalledWith.at(7)?.file.contains(fileName) ?? false)
        XCTAssertEqual(mockTimberApplicationDelegate.stub.logMessageCalledWith.at(7)?.function, functionName)
        XCTAssertEqual(mockTimberApplicationDelegate.stub.logMessageCalledWith.at(7)?.line, timberApplication2ErrorLine)
        XCTAssertEqual(mockTimberApplicationDelegate.stub.logMessageCalledWith.at(7)?.properties?.count, 1)
        XCTAssertEqual(mockTimberApplicationDelegate.stub.logMessageCalledWith.at(7)?.properties?.first?.key, "errorKey2")
        XCTAssertEqual(mockTimberApplicationDelegate.stub.logMessageCalledWith.at(7)?.properties?.first?.value as? String, "errorValue2")
        
        XCTAssertEqual(mockTimberApplicationDelegate.stub.logErrorCalledWith.at(0)?.errorType, .internal)
        XCTAssertEqual(mockTimberApplicationDelegate.stub.logErrorCalledWith.at(0)?.properties.count, 7)
        XCTAssertEqual(mockTimberApplicationDelegate.stub.logErrorCalledWith.at(0)?.properties["File Name"] as? String, fileName)
        XCTAssertEqual(mockTimberApplicationDelegate.stub.logErrorCalledWith.at(0)?.properties["Line"] as? Int, timberApplication1ErrorLine)
        XCTAssertEqual(mockTimberApplicationDelegate.stub.logErrorCalledWith.at(0)?.properties["Version"] as? String, application1Source.version)
        XCTAssertEqual(mockTimberApplicationDelegate.stub.logErrorCalledWith.at(0)?.properties["Function"] as? String, functionName)
        XCTAssertEqual(mockTimberApplicationDelegate.stub.logErrorCalledWith.at(0)?.properties["Error Description"] as? String, TimberErrorType.internal.description)
        XCTAssertEqual(mockTimberApplicationDelegate.stub.logErrorCalledWith.at(0)?.properties["Error Code"] as? Int, TimberErrorType.internal.code)
        XCTAssertEqual(mockTimberApplicationDelegate.stub.logErrorCalledWith.at(0)?.properties["errorKey1"] as? String, "errorValue1")
        XCTAssertEqual(mockTimberApplicationDelegate.stub.logErrorCalledWith.at(0)?.logMessage.message, "error1")
        XCTAssertEqual(mockTimberApplicationDelegate.stub.logErrorCalledWith.at(0)?.logMessage.logLevel, .error)
        XCTAssertEqual(mockTimberApplicationDelegate.stub.logErrorCalledWith.at(0)?.logMessage.consoleMessage, "\(application1Source.emoji) \(application1Source.title) \(application1Source.emoji): \(fileName) [\(timberApplication1ErrorLine)] \(functionName) \(LogLevel.error.emoji) \(TimberErrorType.internal.description) - error1 \(LogLevel.error.emoji) , properties: [\"errorKey1\": \"errorValue1\"]")
        XCTAssertEqual(mockTimberApplicationDelegate.stub.logErrorCalledWith.at(0)?.logMessage.source, application1Source)
        XCTAssertTrue(mockTimberApplicationDelegate.stub.logErrorCalledWith.at(0)?.logMessage.file.contains(fileName) ?? false)
        XCTAssertEqual(mockTimberApplicationDelegate.stub.logErrorCalledWith.at(0)?.logMessage.function, functionName)
        XCTAssertEqual(mockTimberApplicationDelegate.stub.logErrorCalledWith.at(0)?.logMessage.line, timberApplication1ErrorLine)
        XCTAssertEqual(mockTimberApplicationDelegate.stub.logErrorCalledWith.at(0)?.logMessage.properties?.count, 1)
        XCTAssertEqual(mockTimberApplicationDelegate.stub.logErrorCalledWith.at(0)?.logMessage.properties?.first?.key, "errorKey1")
        XCTAssertEqual(mockTimberApplicationDelegate.stub.logErrorCalledWith.at(0)?.logMessage.properties?.first?.value as? String, "errorValue1")
        XCTAssertEqual(mockTimberApplicationDelegate.stub.logErrorCalledWith.at(1)?.errorType, .other)
        XCTAssertEqual(mockTimberApplicationDelegate.stub.logErrorCalledWith.at(1)?.properties.count, 7)
        XCTAssertEqual(mockTimberApplicationDelegate.stub.logErrorCalledWith.at(1)?.properties["File Name"] as? String, fileName)
        XCTAssertEqual(mockTimberApplicationDelegate.stub.logErrorCalledWith.at(1)?.properties["Line"] as? Int, timberApplication2ErrorLine)
        XCTAssertEqual(mockTimberApplicationDelegate.stub.logErrorCalledWith.at(1)?.properties["Version"] as? String, application2Source.version)
        XCTAssertEqual(mockTimberApplicationDelegate.stub.logErrorCalledWith.at(1)?.properties["Function"] as? String, functionName)
        XCTAssertEqual(mockTimberApplicationDelegate.stub.logErrorCalledWith.at(1)?.properties["Error Description"] as? String, TimberErrorType.other.description)
        XCTAssertEqual(mockTimberApplicationDelegate.stub.logErrorCalledWith.at(1)?.properties["Error Code"] as? Int, TimberErrorType.other.code)
        XCTAssertEqual(mockTimberApplicationDelegate.stub.logErrorCalledWith.at(1)?.properties["errorKey2"] as? String, "errorValue2")
        XCTAssertEqual(mockTimberApplicationDelegate.stub.logErrorCalledWith.at(1)?.logMessage.message, "error2")
        XCTAssertEqual(mockTimberApplicationDelegate.stub.logErrorCalledWith.at(1)?.logMessage.logLevel, .error)
        XCTAssertEqual(mockTimberApplicationDelegate.stub.logErrorCalledWith.at(1)?.logMessage.consoleMessage, "\(application2Source.emoji) \(application2Source.title) \(application2Source.emoji): \(fileName) [\(timberApplication2ErrorLine)] \(functionName) \(LogLevel.error.emoji) \(TimberErrorType.other.description) - error2 \(LogLevel.error.emoji) , properties: [\"errorKey2\": \"errorValue2\"]")
        XCTAssertEqual(mockTimberApplicationDelegate.stub.logErrorCalledWith.at(1)?.logMessage.source, application2Source)
        XCTAssertTrue(mockTimberApplicationDelegate.stub.logErrorCalledWith.at(1)?.logMessage.file.contains(fileName) ?? false)
        XCTAssertEqual(mockTimberApplicationDelegate.stub.logErrorCalledWith.at(1)?.logMessage.function, functionName)
        XCTAssertEqual(mockTimberApplicationDelegate.stub.logErrorCalledWith.at(1)?.logMessage.line, timberApplication2ErrorLine)
        XCTAssertEqual(mockTimberApplicationDelegate.stub.logErrorCalledWith.at(1)?.logMessage.properties?.count, 1)
        XCTAssertEqual(mockTimberApplicationDelegate.stub.logErrorCalledWith.at(1)?.logMessage.properties?.first?.key, "errorKey2")
        XCTAssertEqual(mockTimberApplicationDelegate.stub.logErrorCalledWith.at(1)?.logMessage.properties?.first?.value as? String, "errorValue2")
    }
    
    func testUserMessage() {
        timberApplication1.userMessage.toast("none1", displayTime: 1, type: .none)
        timberApplication1.userMessage.toast("success1", displayTime: 2, type: .success)
        timberApplication1.userMessage.toast("failure1", displayTime: 3, type: .failure)
        
        timberApplication2.userMessage.toast("none2", displayTime: 1, type: .none)
        timberApplication2.userMessage.toast("success2", displayTime: 2, type: .success)
        timberApplication2.userMessage.toast("failure2", displayTime: 3, type: .failure)
        
        XCTAssertEqual(mockTimberApplicationDelegate.stub.toastCallCount, 6)
        
        XCTAssertEqual(mockTimberApplicationDelegate.stub.toastCalledWith.at(0)?.message, "none1")
        XCTAssertEqual(mockTimberApplicationDelegate.stub.toastCalledWith.at(0)?.displayTime, 1)
        XCTAssertEqual(mockTimberApplicationDelegate.stub.toastCalledWith.at(0)?.type, ToastType.none)
        XCTAssertEqual(mockTimberApplicationDelegate.stub.toastCalledWith.at(0)?.source, application1Source)
        XCTAssertEqual(mockTimberApplicationDelegate.stub.toastCalledWith.at(1)?.message, "success1")
        XCTAssertEqual(mockTimberApplicationDelegate.stub.toastCalledWith.at(1)?.displayTime, 2)
        XCTAssertEqual(mockTimberApplicationDelegate.stub.toastCalledWith.at(1)?.type, .success)
        XCTAssertEqual(mockTimberApplicationDelegate.stub.toastCalledWith.at(1)?.source, application1Source)
        XCTAssertEqual(mockTimberApplicationDelegate.stub.toastCalledWith.at(2)?.message, "failure1")
        XCTAssertEqual(mockTimberApplicationDelegate.stub.toastCalledWith.at(2)?.displayTime, 3)
        XCTAssertEqual(mockTimberApplicationDelegate.stub.toastCalledWith.at(2)?.type, .failure)
        XCTAssertEqual(mockTimberApplicationDelegate.stub.toastCalledWith.at(2)?.source, application1Source)
        XCTAssertEqual(mockTimberApplicationDelegate.stub.toastCalledWith.at(3)?.message, "none2")
        XCTAssertEqual(mockTimberApplicationDelegate.stub.toastCalledWith.at(3)?.displayTime, 1)
        XCTAssertEqual(mockTimberApplicationDelegate.stub.toastCalledWith.at(3)?.type, ToastType.none)
        XCTAssertEqual(mockTimberApplicationDelegate.stub.toastCalledWith.at(3)?.source, application2Source)
        XCTAssertEqual(mockTimberApplicationDelegate.stub.toastCalledWith.at(4)?.message, "success2")
        XCTAssertEqual(mockTimberApplicationDelegate.stub.toastCalledWith.at(4)?.displayTime, 2)
        XCTAssertEqual(mockTimberApplicationDelegate.stub.toastCalledWith.at(4)?.type, .success)
        XCTAssertEqual(mockTimberApplicationDelegate.stub.toastCalledWith.at(4)?.source, application2Source)
        XCTAssertEqual(mockTimberApplicationDelegate.stub.toastCalledWith.at(5)?.message, "failure2")
        XCTAssertEqual(mockTimberApplicationDelegate.stub.toastCalledWith.at(5)?.displayTime, 3)
        XCTAssertEqual(mockTimberApplicationDelegate.stub.toastCalledWith.at(5)?.type, .failure)
        XCTAssertEqual(mockTimberApplicationDelegate.stub.toastCalledWith.at(5)?.source, application2Source)
    }
    
    // swiftlint:disable:next function_body_length
    func testPerformance() {
        let start1UUID = UUID()
        let start2UUID = UUID()
        let increment1UUID = UUID()
        let increment2UUID = UUID()
        let stop1UUID = UUID()
        let stop2UUID = UUID()
        
        timberApplication1.performance.startTrace(key: "startKey1", identifier: start1UUID, properties: ["key1": "value1"])
        timberApplication1.performance.incrementTraceCounter(key: "incrementKey1", identifier: increment1UUID, named: "named1", by: 1)
        timberApplication1.performance.stopTrace(key: "stopKey1", identifier: stop1UUID)
        
        timberApplication2.performance.startTrace(key: "startKey2", identifier: start2UUID, properties: ["key2": "value2"])
        timberApplication2.performance.incrementTraceCounter(key: "incrementKey2", identifier: increment2UUID, named: "named2", by: 2)
        timberApplication2.performance.stopTrace(key: "stopKey2", identifier: stop2UUID)
        
        XCTAssertEqual(mockTimberApplicationDelegate.stub.startTraceCallCount, 2)
        XCTAssertEqual(mockTimberApplicationDelegate.stub.incrementTraceCounterCallCount, 2)
        XCTAssertEqual(mockTimberApplicationDelegate.stub.stopTraceCallCount, 2)
        
        XCTAssertEqual(mockTimberApplicationDelegate.stub.startTraceCalledWith.at(0)?.key, "startKey1")
        XCTAssertEqual(mockTimberApplicationDelegate.stub.startTraceCalledWith.at(0)?.identifier, start1UUID)
        XCTAssertEqual(mockTimberApplicationDelegate.stub.startTraceCalledWith.at(0)?.properties?.count, 1)
        XCTAssertEqual(mockTimberApplicationDelegate.stub.startTraceCalledWith.at(0)?.properties?.first!.key, "key1")
        XCTAssertEqual(mockTimberApplicationDelegate.stub.startTraceCalledWith.at(0)?.properties?.first!.value as? String, "value1")
        XCTAssertEqual(mockTimberApplicationDelegate.stub.startTraceCalledWith.at(0)?.source, application1Source)
        XCTAssertEqual(mockTimberApplicationDelegate.stub.startTraceCalledWith.at(1)?.key, "startKey2")
        XCTAssertEqual(mockTimberApplicationDelegate.stub.startTraceCalledWith.at(1)?.identifier, start2UUID)
        XCTAssertEqual(mockTimberApplicationDelegate.stub.startTraceCalledWith.at(1)?.properties?.count, 1)
        XCTAssertEqual(mockTimberApplicationDelegate.stub.startTraceCalledWith.at(1)?.properties?.first!.key, "key2")
        XCTAssertEqual(mockTimberApplicationDelegate.stub.startTraceCalledWith.at(1)?.properties?.first!.value as? String, "value2")
        XCTAssertEqual(mockTimberApplicationDelegate.stub.startTraceCalledWith.at(1)?.source, application2Source)
        
        XCTAssertEqual(mockTimberApplicationDelegate.stub.incrementTraceCounterCalledWith.at(0)?.key, "incrementKey1")
        XCTAssertEqual(mockTimberApplicationDelegate.stub.incrementTraceCounterCalledWith.at(0)?.identifier, increment1UUID)
        XCTAssertEqual(mockTimberApplicationDelegate.stub.incrementTraceCounterCalledWith.at(0)?.named, "named1")
        XCTAssertEqual(mockTimberApplicationDelegate.stub.incrementTraceCounterCalledWith.at(0)?.count, 1)
        XCTAssertEqual(mockTimberApplicationDelegate.stub.incrementTraceCounterCalledWith.at(0)?.source, application1Source)
        XCTAssertEqual(mockTimberApplicationDelegate.stub.incrementTraceCounterCalledWith.at(1)?.key, "incrementKey2")
        XCTAssertEqual(mockTimberApplicationDelegate.stub.incrementTraceCounterCalledWith.at(1)?.identifier, increment2UUID)
        XCTAssertEqual(mockTimberApplicationDelegate.stub.incrementTraceCounterCalledWith.at(1)?.named, "named2")
        XCTAssertEqual(mockTimberApplicationDelegate.stub.incrementTraceCounterCalledWith.at(1)?.count, 2)
        XCTAssertEqual(mockTimberApplicationDelegate.stub.incrementTraceCounterCalledWith.at(1)?.source, application2Source)
        
        XCTAssertEqual(mockTimberApplicationDelegate.stub.stopTraceCalledWith.at(0)?.key, "stopKey1")
        XCTAssertEqual(mockTimberApplicationDelegate.stub.stopTraceCalledWith.at(0)?.identifier, stop1UUID)
        XCTAssertEqual(mockTimberApplicationDelegate.stub.stopTraceCalledWith.at(0)?.source, application1Source)
        XCTAssertEqual(mockTimberApplicationDelegate.stub.stopTraceCalledWith.at(1)?.key, "stopKey2")
        XCTAssertEqual(mockTimberApplicationDelegate.stub.stopTraceCalledWith.at(1)?.identifier, stop2UUID)
        XCTAssertEqual(mockTimberApplicationDelegate.stub.stopTraceCalledWith.at(1)?.source, application2Source)
    }
    
    func testNetwork() {
        timberApplication1.network.startedActivity()
        timberApplication1.network.endedActivity()
        
        timberApplication2.network.startedActivity()
        timberApplication2.network.endedActivity()
        
        XCTAssertEqual(mockTimberApplicationDelegate.stub.networkActivityStartedCallCount, 2)
        XCTAssertEqual(mockTimberApplicationDelegate.stub.networkActivityEndedCallCount, 2)
        
        XCTAssertEqual(mockTimberApplicationDelegate.stub.networkActivityStartedCalledWith.at(0), application1Source)
        XCTAssertEqual(mockTimberApplicationDelegate.stub.networkActivityStartedCalledWith.at(1), application2Source)
        
        XCTAssertEqual(mockTimberApplicationDelegate.stub.networkActivityEndedCalledWith.at(0), application1Source)
        XCTAssertEqual(mockTimberApplicationDelegate.stub.networkActivityEndedCalledWith.at(1), application2Source)
    }
}
