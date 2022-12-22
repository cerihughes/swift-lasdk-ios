# ServerObject

The Object we intialize and give **LASDKiOS**

## Overview

* Swift
```swift
@objc final public class ServerObject : NSObject, Sendable {
    /// The **ServerObject's** host
    @objc final public let host: String
    /// The **ServerObject's** scheme
    @objc final public let scheme: String
    /// The **ServerObject's** port
    @objc final public let port: Int
}
```

* Objective-C
```objective-c
    SWIFT_CLASS("_TtC8LASDKiOS12ServerObject")
    @interface ServerObject : NSObject
    /// The ServerObject’s host
    @property (nonatomic, readonly, copy) NSString * _Nonnull host;
    /// The ServerObject’s scheme
    @property (nonatomic, readonly, copy) NSString * _Nonnull scheme;
    /// The ServerObject’s port
    @property (nonatomic, readonly) NSInteger port;
    - (nonnull instancetype)init SWIFT_UNAVAILABLE;
    + (nonnull instancetype)new SWIFT_UNAVAILABLE_MSG("-init is unavailable");
    @end
```
