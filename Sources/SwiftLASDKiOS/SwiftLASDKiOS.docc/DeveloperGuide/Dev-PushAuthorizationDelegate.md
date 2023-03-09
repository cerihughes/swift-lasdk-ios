# PushAuthorizationDelegate

When the agent pushes a document (*not* a URI link) to the consumer, by default **CBA Live Assist** prompts the consumer if they want to view it; if the consumer accepts, it shows the document to the consumer.

An application can supply an PushAuthorizationDelegate in the supportParameters of the call to startSupport (see the <doc:Session-Configuration> section) in order to control whether the consumer sees the document (the consumer does not receive this when the agent pushes a URI). It has a single callback (which is mandatory):
Swift
```swift
public func displaySharedDocumentRequested(_
                                        sharedDocument: SharedDocument,
                                        allow: @Sendable @escaping () -> Void,
                                        deny: @Sendable @escaping () -> Void
    ) async
```

Objective-C
```objective-c
- (void)displaySharedDocumentRequested:(SharedDocument * _Nonnull)sharedDocument 
    allow:(void (^ _Nonnull)(void))allow 
    deny:(void (^ _Nonnull)(void))deny 
    completionHandler:(void (^ _Nonnull)(void))completionHandler
```

The document parameter is an SharedDocument (see the <doc:Dev-DocumentDelegate> section for details). The allow and deny parameters are functions which the application calls to accept or reject sharing of the document:

Swift
```swift
public func displaySharedDocumentRequested(_
                                        sharedDocument: SharedDocument,
                                        allow: @Sendable @escaping () -> Void,
                                        deny: @Sendable @escaping () -> Void
    ) async {
    
        if isSharingAuthorized {
            allow()
        } else {
            deny()
        }
}
```

Objective-C
```objective-c
- (void)displaySharedDocumentRequested:
    (SharedDocument * _Nonnull)sharedDocument 
    allow:(void (^ _Nonnull)(void))allow 
    deny:(void (^ _Nonnull)(void))deny 
    completionHandler:(void (^ _Nonnull)(void))completionHandler {

        if ([self isSharingAuthorized]) {
            allow();
        } else {
            deny();
        }
}
```

In this case, sharing is allowed if the isSharingAuthorized method (not shown, but it could check a flag set in the user interface or some application configuration, or show a bespoke prompt to the user) returns true.

To always show the document without prompting:

Swift
```swift
public func displaySharedDocumentRequested(_
                                        sharedDocument: SharedDocument,
                                        allow: @Sendable @escaping () -> Void,
                                        deny: @Sendable @escaping () -> Void
    ) async {
        allow()
}
```

Objective-C
```objective-c
- (void)displaySharedDocumentRequested:
    (SharedDocument * _Nonnull)sharedDocument 
    allow:(void (^ _Nonnull)(void))allow 
    deny:(void (^ _Nonnull)(void))deny 
    completionHandler:(void (^ _Nonnull)(void))completionHandler {
        allow();
}
```
