# WebSocket Reconnection Control

When a co-browse session disconnects due to technical issues, the default behavior is to attempt to reconnect six times at increasing intervals. You can control this behavior by passing in one or both of the following when the application calls startSupport (see the <doc:Session-Configuration> section):

  - Connection configuration

  - An instance of a delegate which conforms to ASDKConnectionStatusDelegate, allowing an application to perform its own reconnection handling, or to simply inform the user of the status of the current connection.

### Connection Configuration

You can use the optional configuration items retryIntervals, maxReconnectTimeouts, and initialConnectTimeout to control connection and reconnection behavior (see the <doc:Session-Configuration> section):

Swift
```swift
var config = Configuration()
config.retryIntervals = [5.0, 10.0, 15.0]
config.maxReconnectTimeouts = [0.1, 1.0, 10.0]
config.initialConnectTimeout = 30

let sdk = try await AssistSDK.startSupport(config)
```

Objective-C
```objective-c
Configuration *config = [
    [Configuration alloc]
    config.retryIntervals = @[@5.0f,@10.0f,@15.0f];
    config.maxReconnectTimeouts = @[@0.1f,@1.0f,@10.0f];
    config.initialConnectTimeout = 30
];

[AssistSDK startSupport:config completionHandler:^(AssistSDK *sdk, NSError * error) {}];
```

If the WebSocket connection to the **CBA Live Assist** server goes down, **CBA Live Assist** tries to re-establish the connection to the server the number of times specified in the retryIntervals array, with the specified time in seconds between them. The above example sets a timeout for the initial connection of 30 seconds; if the connection is lost, it tries to reconnect 3 times, at intervals of 5, 10, and 15 seconds. The first reconnection attempt will time out after 0.1 seconds, the second after 1 second, and the third after 10 seconds.

**Note:**

  - If you do not specify retryIntervals in the supportParameters, **CBA Live Assist** uses its default values, which are \[@1.0f, @2.0f, @4.0f, @8.0f, @16.0f, @32.0f\]. If you specify an empty array, **CBA Live Assist** makes no reconnection attempts.

  - Reconnection applies only to the case where **CBA Live Assist** loses an existing connection; if the initial connection attempt fails, **CBA Live Assist** does not retry automatically.

### Connection Status Delegate

If the default reconnection behavior of **CBA Live Assist** is not what you want, even after changing the configuration, you can supply an instance of a class which conforms to ConnectionStatusDelegate to implement your own reconnection logic, and include it in the supportParameters passed to startSupport - see the <doc:Session-Configuration> section and the <doc:ConnectionStatusDelegate> section for details.

**Note**: If you do not specify retryIntervals or maxReconnectionTimeouts in supportParameters, **CBA Live Assist** will use its default reconnection behavior; if you specify retryIntervals and maxReconnectionTimeouts in supportParameters, **CBA Live Assist** will use its default reconnection behavior using those values. You can turn off the default reconnection behavior, and take full control of reconnection, by specifying an empty list for retryIntervals.

When implementing your own reconnection logic, the most important notifications you receive are onDisconnect (called whenever the connection is lost) and willRetry (called when automatic reconnection is occurring, and there are more reconnection attempts to come). Both these methods include an ASDKConnector object in their parameters. You can use the ASDKConnector object to make a reconnection attempt (by calling reconnect), or to terminate all reconnection attempts (by calling terminate). The ASDKConnector object remains valid after the call has ended, so the application can also hold onto it for use elsewhere.

| Method | Description |
|-|-|
| onDisconnect | Received when the WebSocket connection to the CBA Live Assist server has been lost, or has failed to reconnect.

This method is called regardless of whether retryIntervals is specified (that is, whether automatic reconnection is active or not).

The Connector object allows the implementing class to control reconnection, even if reconnection is automatic. For example, an application might decide to give up reconnection attempts even if more reconnection attempts would normally occur, or to try the next reconnection attempt immediately without waiting until the next retry interval has passed.

**Note:** The only error this method receives is a transportation error if the network has gone down. 

| Method | Description |
|-|-|
| willRetry | Called under the following conditions:

• when the WebSocket connection is lost; or

• when a reconnection attempt fails and automatic reconnections are occurring (retryIntervals is a non-empty array) and there are more automatic reconnection attempts to be made.

This method is called after the onDisconnect method.

Use the Connector object to override reconnection behavior. For example, a reconnect attempt could be made straight away.

| Method | Description |
|-|-|
| onConnect | Called when a reconnection attempt succeeds.

This may be useful to clear an error indication in the application UI, or for canceling reconnection attempts if the application is managing its own reconnections. 
| Method | Description |
|-|-|
| onTerminated | Called under the following conditions:

• when all reconnection attempts have been made (and failed); or

• when either the `Connector.disconnect()` method or `AssistSDK.endSupport()` method is called. 

#### Example - make a reconnection attempt immediately on disconnection:

In this example, the default reconnection behavior has been disabled, but the user is able choose the reconnection behavior by setting the reconnection\_type flag. In one case, it makes a reconnection attempt immediately; in another, it terminates all reconnection attempts; otherwise, it starts a timer to reconnect in 5 seconds:

Swift
```swift

var reconnector: Connector?
var reconnectionType = ReconnectionType.none

enum ReconnectionType {
    case immeditately, doNotReconnect, none 
}

func onDisconnect(_ connector: Connector, reason: Error) async {

    switch reconnectionType {
    case .immeditately:
        await connector.reconnect(2.0)
    case .doNotReconnect:
        await connector.terminate(reason)
    case .none:
        reconnector = connector
        Timer.sceduledTimer(
            withTimeInterval: 5.0,
            target: self,
            selector: Selector("reconnect"),
            userInfo: nil,
            repeats: false)
    }
}

@objc func reconnect() {
    Task {
        await reconnector?.reconnect(5.0)
    }
}

```

Objective-C
```objective-c
Connector* reconnector;
int reconnection_type;

- (void)onDisconnect:(Connector * _Nonnull)connector reason:(NSError * _Nonnull)reason completionHandler:(void (^ _Nonnull)(void))completionHandler {
    switch (reconnection_type) {
        case RECONNECT_IMMEDIATELY:
        [connector reconnect:2.0f];
        break;
        case DO_NOT_RECONNECT:
        [connector terminate:reason];
        break;
        default:
        // Start timer for reconnection
        reconnector = connector;
        [NSTimer sceduledTimerWithTimeInterval:5.0f target:self
        selector:@selector(reconnect) userInfo:nil repeats:NO];
        break;
    }
    completionHandler();
}

- (void) reconnect {
    [reconnector reconnect:5.0f completionHandler:^{}];
}
```

Example - terminate reconnection attempts in response to user command:

In this example, the default reconnection behavior has not been disabled, but there is a UI control which the user can use to change the maximum number of reconnection attempts. When that maximum number has been reached, reconnection attempts are terminated:

Swift
```swift
func willRetry(_ inSeconds: Float, attempt: Int, of maxAttempts: Int, connector: Connector) async {
    let error = NSError(domain: "UserAction", code: -1)
    await myConnector?.terminate(error)
}
```

Objective-C
```objective-c
- (void) willRetry:(float)inSeconds attempt:(NSInteger)attempt of:(NSInteger)maxAttempts connector:(Connector *)connector completionHandler:(void (^)(void))completionHandler {
if (attempt > userMaxAttempts) {
NSError *error = [NSError errorWithDomain:@"UserAction"
                                                       code:-1
                                                   userInfo:@{NSLocalizedDescriptionKey: NSLocalizedString(@"", nil)}];
[connector terminate:error completionHandler:^{
    completionHandler();
}];
}
}
```
