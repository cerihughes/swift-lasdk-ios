# Migrating from the legacy SDK

This article is to guide you through the changes in LASDKiOS 

## Overview

Starting in LASDKiOS 2.0.0 we have migrated to a native Swift code base. We have modernized the SDK and have changed a few things. Whether you are using Swift or Objective-C we plan to make this as smooth of a transition as possible.

### Imports

- The SDK is called LASDKiOS, previously you would import AssistSDK from LASDKiOS. We have aligned the SDK name with the module you import. So, now rather than importing AssistSDK into your project you simply import LASDKiOS. The examples are shown below.

Swift
```swift
import LASDKiOS
````
Objective-C
```swift
@import LASDKiOS
```
### Threading

- We have created a new threading model built from tools by Apple. This threading model makes the best use of the voice and video concurrency flow. With that being said, whenever you are interacting with the UI in your application while interacting with the call flow, you will need to make sure you are running your code on the main thread. For example when we make a call using LASDKiOS in the sample app, we are interacting with our apps UI during the call flow, therefore we need to make those calls on the main thread. You can run code on the main thread like so. 

Async/Await
```swift
func startSupport() async throws {
// Run on the main thread
    await MainActor.run {
        self.hasStartedConnecting = true
    }
}
```
DispatchQueue
```swift
func startSupport() throws {
// Run on the main thread
    DispatchQueue.main.async {
        self.hasStartedConnecting = true
    }
}
```
Objective-C DispatchQueue
```swift
- (void) startSupport {
    dispatch_async(dispatch_get_main_queue(), ^{
     [self.hasStartedConnecting = YES];
});
}
```
- We also have async versions of methods you may decided to use. If you choose to await on a method your call to that method must be wrapped in a **Task** or the call must be **async**. If you write an async method any FCSDK calls you use will automatically detect that they should use the async version of that call. If you want to side step this logic simply use a Task to wrap the async call instead of writing an async method. For example...

```swift
    func someMethod() async {
// Valid
        self.assistSDK = try await AssistSDK.startSupport(config)

// Invalid, Swift Concurreny will force the await version
        self.assistSDK = AssistSDK.startSupport(config)
}
```

or

```swift
    func someMethod() {
// Valid
Task {
        await startSession()
}
// Valid
        startSession()
    }
```

### Method changes

Bellow are examples of the change in API in Objective-C. Swift users will continues to use an **Int** value.

#### Changes in LASDKiOS while using Swift as a client

```swift
// LASDKiOS 2.0.0 API

// Legacy API

```

#### Changes in LASDKiOS while using Objective-C as a client

```objective-c
// LASDKiOS 2.0.0 API

// Legacy API

```


### Property Name Changes

Swift
```swift 

```
Objective-C
```objective-c

```

### Configuration

- With LASDKiOS we are moving away from using NSDictionary. LASDKiOS uses a class conforming to NSObject as a model layer rather than using Dictionaries. That being said we have created an Object for you to use called **Configuration** and any subsequent child object. This approach simplifies your model layer and makes LASDKiOS easier to work with.


## Available LASDK Objects
<doc:AssistSDK>

<doc:Agent>

<doc:AnnotationDelegate>

<doc:AssistErrorReporter>

<doc:AssistSDKDelegate>

<doc:Configuration>

<doc:ConnectionStatusDelegate>

<doc:Connector>

<doc:ConsumerDocumentDelegate>

<doc:DefaultDocumentViewController>

<doc:DocumentCloseInitiator>

<doc:DocumentDelegate>

<doc:DocumentViewConstraints>

<doc:LASDKErrors>

<doc:LoggingLevel>

<doc:PushAuthorizationDelegate>

<doc:ResponseObject>

<doc:ScreenShareRequestedDelegate>

<doc:ServerObject>

<doc:SharedDocument>

<doc:VideoMode>

<doc:View>



