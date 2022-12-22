# AssistSDKDelegate

The SDK's delegate for informing the client of cobrowse events

## Overview

* Swift
```swift
@objc public protocol AssistSDKDelegate : Sendable {
    @objc func cobrowseActiveDidChange(to active: Bool)
    @objc func supportCallDidEnd()

    /// If a **Swift** App tries to use the** assistSDKDidEncounterError** method to receive error Notifications nothing will happen. Use the **AssistErrorReporter** protocol instead.
    @objc optional func assistSDKDidEncounterError(_ notification: Notification)
}
```

* Objective-C
```objective-c
    SWIFT_PROTOCOL("_TtP8LASDKiOS17AssistSDKDelegate_")
    @protocol AssistSDKDelegate
    - (void)cobrowseActiveDidChangeTo:(BOOL)active;
    - (void)supportCallDidEnd;
    @optional
    /// If a <em>Swift</em> App tries to use the** assistSDKDidEncounterError** method to receive error Notifications nothing will happen. Use the <em>AssistErrorReporter</em> protocol instead.
    - (void)assistSDKDidEncounterError:(NSNotification * _Nonnull)notification;
    @end
```
