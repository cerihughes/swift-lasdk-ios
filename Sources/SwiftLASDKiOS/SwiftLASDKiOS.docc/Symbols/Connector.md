# Connector

An object that wraps our **ComConnectionManager** in order to interact with reconnect or terminate

## Overview

Swift
```swift
@objc final public class Connector : NSObject {

    /// Tells the Connection Manager to reconnect
    @objc final public func reconnect(_ maxTimeout: Float) async

    /// Notifies the needed parties we terminated and give the reason
    /// - Parameter reason: The Reason we terminate
    @objc final public func terminate(_ reason: Error) async
}
```

Objective-C
```objective-c 
    @class Connector;
    SWIFT_CLASS("_TtC8LASDKiOS9Connector")
    @interface Connector : NSObject
    /// Tells the Connection Manager to reconnect
    - (void)reconnect:(float)maxTimeout completionHandler:(void (^ _Nonnull)(void))completionHandler;
    /// Notifies the needed parties we terminated and give the reason
    /// param reason The Reason we terminate
    ///
    - (void)terminate:(NSError * _Nonnull)reason completionHandler:(void (^ _Nonnull)(void))completionHandler;
    - (nonnull instancetype)init SWIFT_UNAVAILABLE;
    + (nonnull instancetype)new SWIFT_UNAVAILABLE_MSG("-init is unavailable");
    @end
```

