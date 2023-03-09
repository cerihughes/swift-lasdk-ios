# AgentCobrowseDelegate

Adopting the AgentCobrowseDelegate enables the application to receive the following notifications, if you decide to conform to this delegate you must handle all of the AgentCobrowseDelegate methods yourself. LASDiOS will not allow a cobrowse session in this scenerio. 

Swift
```swift
@objc func agentJoinedSession(_ agent: Agent) async
```

Objective-C
```objective-c
- (void)agentJoinedSession:(Agent * _Nonnull)agent completionHandler:(void (^ _Nonnull)(void))completionHandler
```

This callback indicates that an agent has answered the support call and joined the support session; this occurs before the agent either requests or initiates co-browsing. The callback allows the developer to pre-approve the agent into the co-browse, before the agent makes the request.

Swift
```swift
func agentRequestedCobrowse(_ agent: Agent) async
```

Objective-C
```objective-c
- (void)agentRequestedCobrowse:(Agent * _Nonnull)agent completionHandler:(void (^ _Nonnull)(void))completionHandler
```

This callback notifies the application that the agent has specifically requested to co-browse. There is no specific requirement for the application to allow or disallow co-browsing at this point, but it is an obvious point to do so. If you do not a cobrowse session will not begin.

Swift
```swift
func agentJoinedCobrowse(_ agent: Agent) async
```

Objective-C
```objective-c
- (void)agentJoinedCobrowse:(Agent * _Nonnull)agent completionHandler:(void (^ _Nonnull)(void))completionHandler
```

This callback occurs when the agent joins the co-browse session.

Swift
```swift
func agentLeftCobrowse(_ agent: Agent) async
```

Objective-C
```objective-c
- (void)agentLeftCobrowse:(Agent * _Nonnull)agent completionHandler:(void (^ _Nonnull)(void))completionHandler
```

This callback occurs when the agent leaves the co-browse session, and can no longer see the consumer’s screen. Leaving the co-browse also resets the agent's co-browse permission; the agent may subsequently request co-browse access again.

Swift
```swift
func agentLeftSession(_ agent: Agent) async
```

Objective-C
```objective-c
- (void)agentLeftSession:(Agent * _Nonnull)agent completionHandler:(void (^ _Nonnull)(void))completionHandler
```

This callback notifies the application that the agent has left the overall support session.

The default implementation displays a dialog box on the consumer's device, asking whether to allow co-browsing or not. If the consumer allows co-browsing, it allows any agent into the co-browsing session whenever they request it. Implementing this interface can give the application more control over which agents are allowed into the co-browsing session, and when. This delegate also allows the application to store the agent value for later use (see the <doc:Allow-Disallow-CoBrowse> section).

Add this delegate to the configuration when the application calls the AssistSDK.startSupport method (see the <doc:Session-Configuration> section).
