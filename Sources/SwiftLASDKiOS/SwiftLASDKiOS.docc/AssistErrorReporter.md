# AssistErrorReporter

Does not need to be represented in **Objective-C** this is a pure **Swift** method for receiving errors, **Objective-C **will continue to use the **AssistSDKDelegate** to receive errors. If a **Swift** App tries to use the** AssistSDKDelegate** to receive error Notifications nothing will happen.

## Overview

* Swift
```swift
public protocol AssistErrorReporter : AnyObject, Sendable {
    func assistSDKDidEncounterError(_ error: LASDKiOS.LASDKErrors) async
}
```
