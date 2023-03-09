# ConnectionStatusDelegate

The ConnectionStatusDelegate has the following methods, which supply notifications about the connection status of the WebSocket connection to the **CBA Live Assist** server:

Swift
```swift
@objc func onConnect() async throws
```

Objective-C
```objective-c
  - onConnect
```

Received when the WebSocket becomes connected to the **CBA Live Assist** server, so that the application can send and receive messages.

**Note:** The application does not need to wait to receive this notification before it can use the **CBA Live Assist** API methods.

Swift
```swift
@objc func onDisconnect(_ connector: Connector, reason: Error) async
```

Objective-C
```objective-c
  - onDisconnect: (NSError)reason connector: (Connector) connector)
```

Received when the WebSocket connection to the **CBA Live Assist** server has been lost, or has failed to reconnect.

Swift
```swift
@objc func onTerminated(_ reason: Error) async
```

Objective-C
```objective-c
  - onTerminated: (NSError) reason
```

Received when the WebSocket connection with the **CBA Live Assist** server has terminated, and there will be no more reconnection attempts. If the termination is due to endSupport being called explicitly, the error code will be AssistSupportEnded (see the <doc:Error-Codes>) section).

Swift
```swift
@objc optional func willRetry(_ inSeconds: Float, attempt: Int, of maxAttempts: Int, connector: Connector) async
```

Objective-C
```objective-c
  - willRetry: (float)inSeconds attempt: (int) attempt of: (int) maxAttempts connector: (Connector) connector)
```

Received when the **CBA Live Assist SDK** is preparing to retry a connection attempt (controlled by the connection configuration which may be supplied in the configuration passed to startSupport; see the <doc:WebSocket-Reconnection-Control> section).

These callbacks can be used to control the reconnection strategy (see the <doc:Dev-ConnectionStatusDelegate> section).

Add this delegate to the configuration when the application calls the AssistSDK startSupport method (see the <doc:Session-Configuration> section).
