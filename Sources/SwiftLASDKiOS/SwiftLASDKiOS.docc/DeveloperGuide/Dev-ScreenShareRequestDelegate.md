# ScreenShareRequestDelegate

Adopting ScreenShareRequestedDelegate allows the application to receive notifications when the agent asks to share the consumer's screen. It has a single method:

Swift
```swift
func assistSDKScreenShareRequested(_ allow: @escaping @MainActor @Sendable () -> Void, deny: @escaping @MainActor @Sendable () -> Void) async
```

Objective-C
```objective-c
- (void)assistSDKScreenShareRequested:(void (^ _Nonnull)(void))allow deny:(void (^ _Nonnull)(void))deny completionHandler:(void (^ _Nonnull)(void))completionHandler
```

Called when the agent has requested to share the consumer's screen. The allow and deny parameters are functions which allow or reject the co-browse request. The application should call one of them.

By default, **CBA Live Assist** pops up a UIAlertViewController which presents the user with options to accept or reject the request. The application can implement this method to override this behavior:

Swift
```swift
func assistSDKScreenShareRequested(_ allow: @escaping @MainActor @Sendable () -> Void, deny: @escaping @MainActor @Sendable () -> Void) async {
    if screenShareAllowed {
        allow()
    } else {
        deny()
    }
}
```

Objective-C
```objective-c
- (void)assistSDKScreenShareRequested:
    (void (^ _Nonnull)(void))allow 
    deny:(void (^ _Nonnull)(void))deny 
    completionHandler:(void (^ _Nonnull)(void))completionHandler {
    if (screenShareAllowed) {
           allow();
        } else {
            deny();
        }
    completionHandler();
}
```
Pass an instance of a class which conforms to the ScreenShareRequestedDelegate protocol to startSupport as the screenShareRequestedDelegate attribute of the supportParams (see the <doc:Session-Configuration> section).
