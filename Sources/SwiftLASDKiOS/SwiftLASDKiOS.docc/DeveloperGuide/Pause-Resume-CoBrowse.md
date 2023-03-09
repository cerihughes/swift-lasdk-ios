# Pausing and Resuming a Co-browsing Session

The application can temporarily pause a co-browse session with the agent by calling:

Swift
```swift
await self.sdk?.pauseCobrowse()
```

Objective-C
```objective-c
[sdk pauseCobrowseWithCompletionHandler:^{}];
```

While paused, the connection to the **CBA Live Assist** server remains open, but the co-browse session is disabled, disabling annotations, document sharing, and so on as a consequence. When the application wishes to resume the co-browsing session, it should call:

Swift
```swift
await self.sdk?.resumeCobrowse()
```

Objective-C
```objective-c
[AssistSDK resumeCobrowse];
```

When the application pauses a co-browse, **CBA Live Assist** notifies the Agent Console, which can present a notification or message to the agent to indicate what has happened.
