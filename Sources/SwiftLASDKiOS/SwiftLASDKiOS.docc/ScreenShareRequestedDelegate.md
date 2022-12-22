# ScreenShareRequestedDelegate

This delegate when conformed to will allow us to accept or deny a screen share triggered by the agent.

## Overview

* Swift
```swift
@objc public protocol ScreenShareRequestedDelegate : NSObjectProtocol {
    @objc func assistSDKScreenShareRequested(_ 
                allow: @escaping @MainActor @Sendable () -> Void, 
                deny: @escaping @MainActor @Sendable () -> Void
                ) async 
}
```

* Objective-C
```objective-c
    SWIFT_PROTOCOL("_TtP8LASDKiOS28ScreenShareRequestedDelegate_")
    @protocol ScreenShareRequestedDelegate <NSObject>
    - (void)assistSDKScreenShareRequested:(void (^ _Nonnull)(void))allow deny:(void (^ _Nonnull)(void))deny completionHandler:(void (^ _Nonnull)(void))completionHandler;
    @end
```
