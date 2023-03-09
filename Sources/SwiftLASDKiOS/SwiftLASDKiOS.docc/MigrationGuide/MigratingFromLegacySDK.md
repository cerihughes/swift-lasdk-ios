# Migrating from the legacy SDK

This article is to guide you through the changes in LASDKiOS 

## Overview

Starting in LASDKiOS 2.0.0 we have migrated to a native Swift code base. We have modernized the SDK and have changed a few things. Whether you are using Swift or Objective-C we plan to make this as smooth of a transition as possible. LASDKiOS is highly Asynchronous in order to ensure thread safety and helps you to make sure UI code is only run on the Main Thread as where the logic is done else where.

We have also made LASDKiOS friendly to use both in Swift and Objective-C as mentioned previously. We will discuss how you consuption of the SDK should be carried out. Think of an AssistSDK session creation to be done in 3 parts depending on how you are desiring to use LASDKiOS.

1. Configuration
2. URL Parsing
3. AssistSDK initialization

These 3 parts are the same as before, but now we handle them sightly different.

**Configuration**

Previously we allowed you to create a dictionary of parameters and feed them into the SDK. This was however very unstructure and a bit more unopinionated than we would like. The SDK requires certain parameter so we now provide you with an object that defines those parameters and then we ask you to feed the object into the SDK. The remainder of the consumption explaination will be explained in the **Swift Programming Language**, however the same can be done in *Objective-C* as indicated later in this article under the SDK's changes and symbol links. The initialization of a Configuration object is simply a Swift class that conforms to NSObject, Sendable, and ObservableObject. This allows us to have dynamic powerful features in your applications and a nice structure to your apps's consumption of the SDK. A Configuration object can be initialize with custom properties on the initializer or one can be initialized with the default values. However in Objective-C you will be required to handle all of the property fields due to the *Nonnull* nature of the initializer, in this scenerio you may pass empty values or the desired value for the given proprty. You may see the Swift initializer of this object in order to see the default values that the **Swift Programming Langauge** allows us to do on the initializer.

**URL Parsing**

There is a use case when you will need to parse a url in order to get the needed credentials for initializing the Configuration object. This is use case is when you are desireing to create a short code session. The **AssistSDK** has a method on it that allows for URL Parsing. This method takes in a Configuration object that has the needed information *(i.e. the server url)* and return a ServerObject for you that contains the **Host**, **Scheme**, and **Port**, you may optionally pass in the serverURL on it's own as a string parameter. The returned object will contain what you need to create a url request that retrieves the short code result. This is needed to get back a *JSON Object* containing the 3 properties required to intitialize an **AssistSDK** session, namely **cid**, **session-token**, and **shortCode**. With these 3 properties you will then be able to feed the result into a new or updated Configuration Object that is used to initialize the **AssistSDK** support session.

**AssistSDK Initialization**

Whether you are using **ShortCode** or **AssistSDK** directly the initialization of *AssistSDK* is the same. However it is quite different from the legacy version. AssistSDK contains both static and singleton methods we need during the support session. In **Swift** we use Swift Concurrency for controlling the concurrent behavior. In **Objective-C** the Swift/OBJC bridge converts an **Async/Await** function in to a completionHandler. Once we have created the session we may access the singleton logic in order to perform the needed behavior of the SDK. The only time we use class functions on **AssistSDK** is when we 1. Adding or Removing the needed delegated, 2. parsing the URL and 3. starting the support session. All of the other calls and or properties are done as a singleton object called **shared**.  



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

## API Changes
With our API being a new breaking API, we have renamed some of the objects, properties, methods, etc. In some unique case you may or may not have a Symbol with the same name. If this is the scenerio for you, you may call excplicitly our Symbol by prepending the Name with **LASDKiOS** so for example...
```swift
LASDKiOS.Configuration
```

### Protocol changes

Bellow are examples of the change in API in Objective-C. Swift users will continues to use an **Int** value.

#### Changes in LASDKiOS while using Swift as a client

Swift
```swift
// LASDKiOS 2.0.0 API
AnnotationDelegate
ConsumerDocumentDelegate
DocumentDelegate
ScreenShareRequestedDelegate
ConnectionStatusDelegate

// Legacy API
AssistSDKAnnotationDelegate
AssistSDKConsumerDocumentDelegate
ASDKDocumentDelegate
ASDKScreenShareRequestedDelegate
ASDKConnectionStatusDelegate
```
### Protocol conformance changes

**LASDKiOS 2.0.0 API**Swift
```swift

//SharedDocumentDownloadDelegate
func documentFailed(toDownload sharedDocument: LASDKiOS.SharedDocument) async {}
func documentFinished(downloading sharedDocument: LASDKiOS.SharedDocument) async throws {}

//AgentCobrowseDelegate
func agentJoinedSession(_ agent: LASDKiOS.Agent) async {}
func agentLeftSession(_ agent: LASDKiOS.Agent) async {}
func agentRequestedCobrowse(_ agent: LASDKiOS.Agent) async {}
func agentJoinedCobrowse(_ agent: LASDKiOS.Agent) async {}
func agentLeftCobrowse(_ agent: LASDKiOS.Agent) async {}

//ConnectionStatusDelegate
func onDisconnect(_ connector: LASDKiOS.Connector, reason: Error) async {}
func onConnect() async throws {}
func onTerminated(_ reason: Error) async {}
func willRetry(_ inSeconds: Float, attempt: Int, of maxAttempts: Int, connector: Connector) async {}

//PushAuthorizationDelegate
var documentRequestedAlertController: UIAlertController?
func displaySharedDocumentRequested(_ sharedDocument: LASDKiOS.SharedDocument, allow: @escaping @Sendable () -> Void, deny: @escaping @Sendable () -> Void) async {}
func dismissDialog() async {}

//DocumentDelegate
func onOpened(_ document: SharedDocument) {}
func onClosed(_ document: SharedDocument, by: DocumentCloseInitiator) {}
func onError(_ document: SharedDocument, reason: String) {}

//ConsumerDocumentDelegate
func onConsumerDocError(_ document: LASDKiOS.SharedDocument?, reason reasonStr: String?) {}
func onConsumerDocClosed(_ document: LASDKiOS.SharedDocument?, by whom: LASDKiOS.DocumentCloseInitiator) {}

//AnnotationDelegate
func assistSDKWillAddAnnotation(_ notification: Notification?) {}
func assistSDKDidAddAnnotation(_ notification: Notification?) {}
func assistSDKDidClearAnnotations(_ notification: Notification?) {}

//ScreenShareRequestedDelegate
func assistSDKScreenShareRequested(_ allow: @escaping @MainActor @Sendable () -> Void, deny: @escaping @MainActor @Sendable () -> Void) async {}

//DocumentViewConstraints
var topMargin: CGFloat = 0
var bottomMargin: CGFloat = 0
var leftMargin: CGFloat = 0
var rightMargin: CGFloat = 0

//DocumentMessageSender
func sendDocumentFailedMessage(_ sharedDoc: LASDKiOS.SharedDocument) async {}
func sendDocumentSucceededMessage(_ sharedDoc: LASDKiOS.SharedDocument) async {}
func sendDocumentRejectedMessage(_ sharedDoc: LASDKiOS.SharedDocument) async {}
func sendDocumentAcceptedMessage(_ sharedDoc: LASDKiOS.SharedDocument) async {}
func sendDocumentClosedMessage(_ sharedDoc: LASDKiOS.SharedDocument, initiator: LASDKiOS.DocumentCloseInitiator) async {}
```


**Legacy API**Swift
```swift

//SharedDocumentDownloadDelegate
func documentDidFinishDownloading(_ sharedDocument: ASDKSharedDocument!) {}
func documentFailed(toDownload sharedDocument: ASDKSharedDocument!) {}

//AgentCobrowseDelegate
func agentJoinedSession(_ agent: ASDKAgent!) {}
func agentLeftSession(_ agent: ASDKAgent!) {}
func agentRequestedCobrowse(_ agent: ASDKAgent!) {}
func agentJoinedCobrowse(_ agent: ASDKAgent!) {}
func agentLeftCobrowse(_ agent: ASDKAgent!) {}

//ConnectionStatusDelegate
func onDisconnect(_ reason: Error!, connector: ASDKConnector!) {}
func onConnect() {}
func onTerminated(_ reason: Error!) {}
func willRetry(_ inSeconds: Float, attempt: Int32, of maxAttempts: Int32, connector: ASDKConnector!) {}

//PushAuthorizationDelegate
func displaySharedDocumentRequested(_ sharedDocument: ASDKSharedDocument!, allow: (() -> Void)!, deny: (() -> Void)!) {}

//DocumentDelegate
func onError(_ document: ASDKSharedDocument!, reason reasonStr: String!) {}
func onClosed(_ document: ASDKSharedDocument!, by whom: AssistSDKDocumentCloseInitiator) {}
func onOpened(_ document: ASDKSharedDocument!) {}

//ConsumerDocumentDelegate
func onError(_ document: ASDKSharedDocument!, reason reasonStr: String!) {}
func onClosed(_ document: ASDKSharedDocument!, by whom: AssistSDKDocumentCloseInitiator) {}

//AnnotationDelegate
func assistSDKWillAddAnnotation(_ notification: Notification!) {}
func assistSDKDidAddAnnotation(_ notification: Notification!) {}
func assistSDKDidClearAnnotations(_ notification: Notification!) {}

//ScreenShareRequestedDelegate
func assistSDKScreenShareRequested(_ allow: (() -> Void)!, deny: (() -> Void)!) {}

//DocumentViewConstraints
func topMargin() -> Float { return 0.0 }
func bottomMargin() -> Float { return 0.0 }
func leftMargin() -> Float { return 0.0 }
func rightMargin() -> Float { return 0.0 }

//DocumentMessageSender
func sendDocumentFailedMessage(_ sharedDoc: ASDKSharedDocument!) {}
func sendDocumentSucceededMessage(_ sharedDoc: ASDKSharedDocument!) {}
func sendDocumentRejectedMessage(_ sharedDoc: ASDKSharedDocument!) {}
func sendDocumentAcceptedMessage(_ sharedDoc: ASDKSharedDocument!) {}
func sendDocumentClosedMessage(_ sharedDoc: ASDKSharedDocument!, initiator: UInt16) {}

```
**LASDKiOS 2.0.0 API*Objective-C
```objective-c
//SharedDocumentDownloadDelegate
- (void)documentFailedToDownload:(SharedDocument * _Nonnull)sharedDocument completionHandler:(void (^ _Nonnull)(void))completionHandler {}
- (void)documentFinishedWithDownloading:(SharedDocument * _Nonnull)sharedDocument completionHandler:(void (^ _Nonnull)(NSError * _Nullable))completionHandler {}

//AgentCobrowseDelegate
- (void)agentJoinedCobrowse:(Agent * _Nonnull)agent completionHandler:(void (^ _Nonnull)(void))completionHandler {}
- (void)agentJoinedSession:(Agent * _Nonnull)agent completionHandler:(void (^ _Nonnull)(void))completionHandler {}
- (void)agentLeftCobrowse:(Agent * _Nonnull)agent completionHandler:(void (^ _Nonnull)(void))completionHandler {}
- (void)agentLeftSession:(Agent * _Nonnull)agent completionHandler:(void (^ _Nonnull)(void))completionHandler {}
- (void)agentRequestedCobrowse:(Agent * _Nonnull)agent completionHandler:(void (^ _Nonnull)(void))completionHandler {}

//ConnectionStatusDelegate
- (void)onConnectWithCompletionHandler:(void (^ _Nonnull)(NSError * _Nullable))completionHandler {}
- (void)onDisconnect:(Connector * _Nonnull)connector reason:(NSError * _Nonnull)reason completionHandler:(void (^ _Nonnull)(void))completionHandler {}
- (void)onTerminated:(NSError * _Nonnull)reason completionHandler:(void (^ _Nonnull)(void))completionHandler {}
- (void) willRetry:(float)inSeconds attempt:(NSInteger)attempt of:(NSInteger)maxAttempts connector:(Connector *)connector completionHandler:(void (^)(void))completionHandler {}

//PushAuthorizationDelegate
@synthesize documentRequestedAlertController;
- (void)dismissDialogWithCompletionHandler:(void (^ _Nonnull)(void))completionHandler {}
- (void)displaySharedDocumentRequested:(SharedDocument * _Nonnull)sharedDocument allow:(void (^ _Nonnull)(void))allow deny:(void (^ _Nonnull)(void))deny completionHandler:(void (^ _Nonnull)(void))completionHandler {}

//DocumentDelegate
- (void) onOpened:(SharedDocument *)document {}
- (void) onClosed:(SharedDocument *)document by:(enum DocumentCloseInitiator)by {}
- (void) onError:(SharedDocument *)document reason:(NSString *)reason {}

//ConsumerDocumentDelegate
- (void)onConsumerDocClosed:(SharedDocument * _Nullable)document by:(enum DocumentCloseInitiator)whom {}
- (void)onConsumerDocError:(SharedDocument * _Nullable)document reason:(NSString * _Nullable)reasonStr {}

//AnnotationDelegate
- (void)assistSDKDidAddAnnotation:(NSNotification * _Nullable)notification {}
- (void)assistSDKDidClearAnnotations:(NSNotification * _Nullable)notification {}
- (void)assistSDKWillAddAnnotation:(NSNotification * _Nullable)notification {}

//ScreenShareRequestedDelegate
- (void)assistSDKScreenShareRequested:(void (^ _Nonnull)(void))allow deny:(void (^ _Nonnull)(void))deny completionHandler:(void (^ _Nonnull)(void))completionHandler {}

//DocumentViewConstraints
@synthesize topMargin;
@synthesize bottomMargin;
@synthesize leftMargin;
@synthesize rightMargin;

//DocumentMessageSender
- (void)sendDocumentAcceptedMessage:(SharedDocument * _Nonnull)sharedDoc completionHandler:(void (^ _Nonnull)(void))completionHandler {}
- (void)sendDocumentClosedMessage:(SharedDocument * _Nonnull)sharedDoc initiator:(enum DocumentCloseInitiator)initiator completionHandler:(void (^ _Nonnull)(void))completionHandler {}
- (void)sendDocumentFailedMessage:(SharedDocument * _Nonnull)sharedDoc completionHandler:(void (^ _Nonnull)(void))completionHandler {}
- (void)sendDocumentRejectedMessage:(SharedDocument * _Nonnull)sharedDoc completionHandler:(void (^ _Nonnull)(void))completionHandler {}
- (void)sendDocumentSucceededMessage:(SharedDocument * _Nonnull)sharedDoc completionHandler:(void (^ _Nonnull)(void))completionHandler {}
```

**Legacy API**Objective-C
```objective-c
//SharedDocumentDownloadDelegate
- (void)documentDidFinishDownloading:(ASDKSharedDocument *)sharedDocument {}
- (void)documentFailedToDownload:(ASDKSharedDocument *)sharedDocument {}

//AgentCobrowseDelegate
- (void)agentJoinedCobrowse:(ASDKAgent *)agent {}
- (void)agentJoinedSession:(ASDKAgent *)agent {}
- (void)agentLeftCobrowse:(ASDKAgent *)agent {}
- (void)agentLeftSession:(ASDKAgent *)agent {}
- (void)agentRequestedCobrowse:(ASDKAgent *)agent {}

//ConnectionStatusDelegate
- (void)onConnect {}
- (void)onDisconnect:(NSError *)reason connector:(ASDKConnector *)connector {}
- (void)onTerminated:(NSError *)reason {}
- (void) willRetry:(float) inSeconds attempt:(int) attempt of:(int) maxAttempts connector:(Connector *) connector {}];

//PushAuthorizationDelegate
- (void)displaySharedDocumentRequested:(ASDKSharedDocument *)sharedDocument allow:(void (^)(void))allow deny:(void (^)(void))deny {}

//DocumentDelegate
- (void) onError:(ASDKSharedDocument *)document reason:(NSString *)reasonStr {}
- (void) onClosed:(ASDKSharedDocument *)document by:(AssistSDKDocumentCloseInitiator)whom {}
- (void) onOpened:(ASDKSharedDocument *)document {}

//ConsumerDocumentDelegate
- (void) onError:(ASDKSharedDocument *)document reason:(NSString *)reasonStr {}
- (void) onClosed:(ASDKSharedDocument *)document by:(AssistSDKDocumentCloseInitiator)whom {}

//AnnotationDelegate
- (void) assistSDKDidAddAnnotation:(NSNotification *)notification {}
- (void) assistSDKWillAddAnnotation:(NSNotification *)notification {}
- (void) assistSDKDidClearAnnotations:(NSNotification *)notification {}

//ScreenShareRequestedDelegate
- (void)assistSDKScreenShareRequested:(void (^)(void))allow deny:(void (^)(void))deny {}

//DocumentViewConstraints
- (float)bottomMargin { return 0.0f; }
- (float)leftMargin { return 0.0f; }
- (float)rightMargin { return 0.0f; }
- (float)topMargin { return 0.0f; }

//DocumentMessageSender
- (void)sendDocumentAcceptedMessage:(ASDKSharedDocument *)sharedDoc {}
- (void)sendDocumentClosedMessage:(ASDKSharedDocument *)sharedDoc initiator:(unsigned short)initiator {}
- (void)sendDocumentFailedMessage:(ASDKSharedDocument *)sharedDoc {}
- (void)sendDocumentRejectedMessage:(ASDKSharedDocument *)sharedDoc {}
- (void)sendDocumentSucceededMessage:(ASDKSharedDocument *)sharedDoc {}
```
*New Protocols* are used typically in places where we can use a more Swifty approach or needed to maintain certain Objective-C functionality

```swift 
public protocol AssistErrorReporter : AnyObject, Sendable {
func assistSDKDidEncounterError(_ error: LASDKiOS.LASDKErrors) async
}
```

### Object changes


#### Changes in LASDKiOS while using Swift as a client

Swift
```swift
// LASDKiOS 2.0.0 API
Connector
DefaultDocumentViewController
SharedDocument

// Legacy API
ASDKConnector
ASDKDefaultDocumentViewController
ASDKSharedDocument
```
**New Objects**

*New Objects* are used typically in places where loose messy Dictionaries were used in the Legacy SDK. These Objects make it easier for you to use and provide a cleaner code base in you applications.

```swift
@objc final public class Agent: NSObject, Sendable {}
@objc final public class Configuration: NSObject, ObservableObject, Sendable {}
@objc final public class ServerObject: NSObject, Sendable {}
```

**Symbols**

<doc:Agent>

<doc:Configuration>

<doc:ServerObject>

### Method changes

Bellow are examples of the change in API in Objective-C. Swift users will continues to use an **Int** value.

#### Changes in LASDKiOS while using Swift as a client

**LASDKiOS 2.0.0 API**Swift
```swift
Task {
    let sdk = try await AssistSDK.startSupport(Configuration())
    _ = sdk.allowCobrowse(for: Agent())
    _ = sdk.disallowCobrowse(for: Agent())
    _ = try await AssistSDK.parseURL(Configuration())
    _ = await sdk.endSupport()
    _ = await sdk.pauseCobrowse()
    _ = await sdk.resetAllWebPermissions()
    _ = await sdk.resumeCobrowse()
    _ = await sdk.setPermission("", for: UIView())
    _ = await sdk.setWebPermissions("", webElementId: "")
    _ = try await sdk.shareDocumentUrl(URL(string: "")!, delegate: self)
    _ = await sdk.assistSDKDidEncounterError(LASDKErrors.assistConsumerDocumentShareFailedNotScreenSharing)
    _ = await sdk.reportError(LASDKErrors.assistConsumerDocumentShareFailedNotScreenSharing)
    AssistSDK.removeDelegate(self)
    AssistSDK.addDelegate(self)
}
```
**Legacy API**Swift
```swift 
let sdk = AssistSDK.startSupport("", destination: "")
AssistSDK.addDelegate(self)
AssistSDK.allowCobrowse(for: ASDKAgent())
AssistSDK.allowConsumerShareWhenNotInCoBrowse()
AssistSDK.disallowCobrowse(for: ASDKAgent())
AssistSDK.pauseCobrowse()
AssistSDK.endSupport()
AssistSDK.resumeCobrowse()
AssistSDK.resetAllWebPermissions()
AssistSDK.parseServerInfo("")
AssistSDK.removeDelegate(self)
AssistSDK.supportParameters()
AssistSDK.setPermission("", for: UIView())
AssistSDK.setPermission("", forWebElementWithId: "")
AssistSDK.shareDocument(Data(), mimeType: "", delegate: self)
AssistSDK.shareDocumentUrl("", delegate: self)
AssistSDK.shareDocumentNSUrl(URL(string: "")!, delegate: self)
```

#### Changes in LASDKiOS while using Objective-C as a client

**LASDKiOS 2.0.0 API*Objective-C
```objective-c
[AssistSDK startSupport:config completionHandler:^(AssistSDK *sdk, NSError * error) {
    [sdk allowCobrowseFor:agent completionHandler:^{}];
    [sdk disallowCobrowseFor:agent completionHandler:^{}];
    [sdk pauseCobrowseWithCompletionHandler:^{}];
    [sdk resumeCobrowseWithCompletionHandler:^{}];
    [sdk shareDocumentUrl:url delegate:self completionHandler:^(NSError *error) {}];
    [sdk setPermission:@"" for:view completionHandler:^{}];
    [sdk setWebPermissions:@"" webElementId:@"" completionHandler:^{}];
    [sdk resetAllWebPermissionsWithCompletionHandler:^{}];
    [sdk allowConsumerShareWhenNotInCoBrowse];
    [sdk endSupport];
}];
    [AssistSDK addDelegate:self];
    [AssistSDK removeDelegate:self];
    [AssistSDK parseURL:config serverURL:@"" completionHandler:^(ServerObject * serverObject, NSError * error) {}];

Connector *connector = [Connector alloc];
[connector reconnect:0.0 completionHandler:^{}];
[connector terminate:error completionHandler:^{}];
```
**Legacy API**Objective-C
```objective-c 
//AssistSDK
[AssistSDK startSupport:@"" destination:@""];
NSDictionary *dict = [NSDictionary alloc];
[AssistSDK startSupport:@"" supportParameters:dict];
[AssistSDK allowCobrowseForAgent:agent];
[AssistSDK disallowCobrowseForAgent:agent];
[AssistSDK pauseCobrowse];
[AssistSDK resumeCobrowse];
[AssistSDK shareDocumentUrl:@"" delegate:self];
[AssistSDK shareDocumentNSUrl:url delegate:self];
[AssistSDK shareDocument:data mimeType:@"" delegate:self];
[AssistSDK setPermission:@"" forView:view];
[AssistSDK setPermission:@"" forWebElementWithId:@""];
[AssistSDK resetAllWebPermissions];
[AssistSDK allowConsumerShareWhenNotInCoBrowse];
[AssistSDK endSupport];
[AssistSDK addDelegate:self];
[AssistSDK removeDelegate:self];
[AssistSDK parseServerInfo:@""];

//Connector
ASDKConnector *connector = [ASDKConnector alloc];
[connector reconnect:0.0f];
[connector terminate:error];
```

### Property Name Changes

**LASDKiOS 2.0.0 API**Swift
```swift 
// Removed
```
**Legacy API**Swift
```swift
// Legacy API
public let kASDKSVGPathKey: String
public let kASDKSVGLayerKey: String
public let kASDKSVGPathStrokeKey: String
public let kASDKSVGPathStrokeWidthKey: String
public let kASDKSVGPathStrokeOpacityKey: String
```

**LASDKiOS 2.0.0 API*Objective-C
```objective-c
// Removed
```
**Legacy API**Objective-C
```objective-c 
extern NSString *kASDKSVGPathKey;
extern NSString *kASDKSVGLayerKey;
extern NSString *kASDKSVGPathStrokeKey;
extern NSString *kASDKSVGPathStrokeWidthKey;
extern NSString *kASDKSVGPathStrokeOpacityKey;
```

### Enumeration Name Changes

**LASDKiOS 2.0.0 API**Swift
```swift
.fcsdkSessionFailure
.fcsdkSystemFailure
.fcsdkLostConnection
.fcsdkDidReceiveCallFailure
.fcsdkDidReceiveDialFailure
.calleeNotFound
.assistSessionCreationFailure
.assistConsumerDocumentShareFailedNotScreenSharing
.assistSupportEnded
.calleeBusy
.callCreationFailed
.callTimeout
.callFailed
.sessionFailure
.cameraNotAuthorized
.microphoneNotAuthorized
.assistTransportFailure
.assistSessionInProgress
.unknownMimeType

.closedByUnknown
.closedByAgent
.closedByConsumer 
.closedBySupportEnded
```
**Legacy API**Swift
```swift
ASDKERRCalleeNotFound
ASDKERRCalleeBusy
ASDKERRCallCreationFailed
ASDKERRCallTimeout
ASDKERRCallFailed
ASDKERRCSDKSessionFailure
ASDKERRCameraNotAuthorized
ASDKERRMicrophoneNotAuthorized
ASDKERRAssistSessionCreationFailure
ASDKERRAssistTransportFailure
ASDKERRAssistSessionInProgress
ASDKERRAssistConsumerDocumentShareFailedNotScreenSharing
ASDKAssistSupportEnded

AssistSDKDocumentClosedByAgent
AssistSDKDocumentClosedByConsumer
AssistSDKDocumentClosedByUnknown
AssistSDKDocumentClosedBySupportEnded
```

**LASDKiOS 2.0.0 API*Objective-C
```objective-c
LASDKErrorsFcsdkSessionFailure
LASDKErrorsFcsdkSystemFailure
LASDKErrorsFcsdkLostConnection
LASDKErrorsFcsdkDidReceiveCallFailure
LASDKErrorsFcsdkDidReceiveDialFailure
LASDKErrorsCalleeNotFound
LASDKErrorsAssistSessionCreationFailure
LASDKErrorsAssistConsumerDocumentShareFailedNotScreenSharing
LASDKErrorsAssistSupportEnded
LASDKErrorsCalleeBusy
LASDKErrorsCallCreationFailed
LASDKErrorsCallTimeout
LASDKErrorsCallFailed
LASDKErrorsSessionFailure
LASDKErrorsCameraNotAuthorized
LASDKErrorsMicrophoneNotAuthorized
LASDKErrorsAssistTransportFailure
LASDKErrorsAssistSessionInProgress
LASDKErrorsUnknownMimeType

DocumentCloseInitiatorClosedByAgent
DocumentCloseInitiatorClosedByConsumer
DocumentCloseInitiatorClosedByUnknown
DocumentCloseInitiatorClosedBySupportEnded
```
**Legacy API**Objective-C
```objective-c
ASDKERRCalleeNotFound
ASDKERRCalleeBusy
ASDKERRCallCreationFailed
ASDKERRCallTimeout
ASDKERRCallFailed
ASDKERRCSDKSessionFailure
ASDKERRCameraNotAuthorized
ASDKERRMicrophoneNotAuthorized
ASDKERRAssistSessionCreationFailure
ASDKERRAssistTransportFailure
ASDKERRAssistSessionInProgress
ASDKERRAssistConsumerDocumentShareFailedNotScreenSharing
ASDKAssistSupportEnded

AssistSDKDocumentClosedByAgent
AssistSDKDocumentClosedByConsumer
AssistSDKDocumentClosedByUnknown
AssistSDKDocumentClosedBySupportEnded
```

### Configuration

**IMPORTANT**
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



