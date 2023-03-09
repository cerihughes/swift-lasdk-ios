# Using CBA Live Assist without Voice and Video

You can use **CBA Live Assist** in **co-browse only** mode, if the voice or video call is provided independently of **Fusion Client SDK** and **CBA Live Assist**, or when something like a chat session is used instead of a voice and video call.

To prevent **CBA Live Assist** from placing a call using the **Fusion Client SDK**, the application should provide a **correlation ID** that **CBA Live Assist** uses to correlate the consumer and agent sides of the co-browsing session. This allows an application to use the features of **CBA Live Assist** (for example, co-browsing, document push, annotation, and remote control) without voice or video.

To create a **CBA Live Assist** session without voice and video, provide a correlation ID in the supportParameters which you pass to startSupport:

Swift
```swift
let config = Configuration(correlationId: "correlation-123")
try await AssistSDK.startSupport(config)
```

Objective-C
```objective-c
Configuration *config = [Configuration alloc];
config.correlationId = @"correlation-123";
[AssistSDK startSupport:config completionHandler:^(AssistSDK *sdk, NSError * error) {}];
```

In this case, you should *not* supply a destination in the supportParameters.
**Note:**
  - In a co-browse only session, the application must explicitly call endSupport when the call ends (or when the co-browse session is no longer needed), as **CBA Live Assist** does not present its default UI to the user.

  - The correlation ID needs to be known to both parties in the call, and needs to be unique enough that the same correlation ID is not used by two support calls at the same time. The application developer must decide the mechanism by which this happens, but possible ways are for both parties to calculate a value from data about the call known to both of them, or for one side to generate it and communicate it to the other on the existing communication channel. There is also a REST service provided by **CBA Live Assist** which will create a correlation ID and associate it with a short code; see the [Informing the Agent of the Correlation ID](#informing-the-agent-of-the-correlation-id) section.
