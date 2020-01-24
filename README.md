# TimberSwift

[![Carthage Compatible](https://img.shields.io/badge/Carthage-compatible-4BC51D.svg?style=flat)](https://github.com/Carthage/Carthage)
[![Swift 5.1](https://img.shields.io/badge/Swift-5.1-orange.svg?style=flat)](https://developer.apple.com/swift/)
[![Platforms](https://img.shields.io/badge/Platforms-macOS%20%7C%20Linux%20%7C%20iOS%20%7C%20tvOS%20%7C%20watchOS-green.svg?style=flat)](https://swift.org/package-manager/)

What is TimberSwift?

A library to send all messages from either frameworks or the parent application to the parent application for consumption. This means the parent application will solely be responsible for sending to: The console, UI toasting, monitoring network activity, sending to Flurry / Google Analytics / Firebase / Crashlytics, some logging solution, or `> /dev/null`.

## Workflows

- Logging
  - Error, Warning, Debug, Info
  - A console friendly message is passed to the parent application
  - Errors are ALSO passed to a seperate method and are expected to be logged to an error logging solution such as Crashlytics non-fatal logging
- Analytics
  - Set screen name for workflow
  - Log an event
- User Messaging
  - Toast messages
- Performance
  - Measuring the time is takes between starting, incrementating, and stopping a trace.
- Networking
  - Network Activity

## Installation

### Carthage

```github "MonsantoCo/TimberSwift" ~> 0.3.0```

### Package Manager

```.package(url: "git@github.com:MonsantoCo/TimberSwift.git", from: "0.3.0")```

## Instructions

### Create a Timber object and begin using any or all of the workflows

```
timber.performance.startTrace(key: "Some Key", properties: ["Some": "Things for the trace"])
timber.performance.incrementTraceCounter(key: "Some Key")
timber.performance.stopTrace(key: "Some Key")
timber.log.debug("A message", properties: ["More": "Info"])
timber.log.info("A message", properties: ["More": "Info"])
timber.log.warning("A message", properties: ["More": "Info"])
timber.log.error("A message", errorType: .http(statusCode: 500), properties: ["Error": "Info"])
timber.userMessage.toast("Hi There", displayTime: 2.0, type: .success)
timber.analytics.setScreen(title: "The Main Map")
timber.analytics.recordEvent(title: "Downloading Everything", properties: ["Specific": "Info"])
timber.network.startedActivity()
timber.network.endedActivity()
```

### The parent application should assign itself as the TimberApplicationDelegate as soon as possble to receive any and all messages from Timber objects.

```
func setScreen(title: String, source: Source)
func recordEvent(title: String, properties: [String: Any]?, source: Source)
func log(_ logMessage: LogMessage)
func log(_ error: TimberError)
func toast(_ message: String, displayTime: TimeInterval, type: ToastType, source: Source)
func startTrace(key: String, identifier: UUID?, properties: [String: Any]?, source: Source)
func incrementTraceCounter(key: String, identifier: UUID?, named: String, by count: Int, source: Source)
func stopTrace(key: String, identifier: UUID?, source: Source)
func networkActivityStarted(source: Source)
func networkActivityEnded(source: Source)
```
