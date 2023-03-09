# ConnectionStatusDelegate

The SDK's delegate for informing the client about WebSocket connection information

## Overview

Swift
```swift
@objc public protocol ConnectionStatusDelegate : NSObjectProtocol, Sendable {
    @objc func onDisconnect(_ connector: LASDKiOS.Connector, reason: Error) async
    @objc func onConnect() async throws
    @objc func onTerminated(_ reason: Error) async
    @objc optional func willRetry(_ 
                            inSeconds: Float, 
                            attempt: Int,
                            of maxAttempts: Int, 
                            connector: LASDKiOS.Connector
                            ) async
}
```

Objective-C
```objective-c
    SWIFT_PROTOCOL("_TtP8LASDKiOS24ConnectionStatusDelegate_")
    @protocol ConnectionStatusDelegate <NSObject>
    - (void)onDisconnect:(Connector * _Nonnull)connector reason:(NSError * _Nonnull)reason completionHandler:(void (^ _Nonnull)(void))completionHandler;
    - (void)onConnectWithCompletionHandler:(void (^ _Nonnull)(NSError * _Nullable))completionHandler;
    - (void)onTerminated:(NSError * _Nonnull)reason completionHandler:(void (^ _Nonnull)(void))completionHandler;
    @optional
    - (void)willRetry:(float)inSeconds attempt:(NSInteger)attempt of:(NSInteger)maxAttempts connector:(Connector * _Nonnull)connector completionHandler:(void (^ _Nonnull)(void))completionHandler;
    @end
```
