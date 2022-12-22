# PushAuthorizationDelegate

When the agent pushes a document (not a URI link) to the consumer, by default CBA Live Assist prompts the consumer if they want to view it; if the consumer accepts, it shows the document to the consumer.
An application can supply an PushAuthorizationDelegate in the supportParameters of the call to startSupport (see the Session Configuration section) in order to control whether the consumer sees the document (the consumer does not receive this when the agent pushes a URI). It has a single callback (which is mandatory):
The document parameter is an **SharedDocument** (see the **SharedDocument** section for details). The allow and deny parameters are functions which the application calls to accept or reject sharing of the document:

## Overview

* Swift
```swift
@MainActor @objc public protocol PushAuthorizationDelegate : NSObjectProtocol {

    /// Our **UIAlertController** to show to request permission
    @objc @MainActor var documentRequestedAlertController: UIAlertController? { get set }

    /// This method is designed to ask the consumer if the want to allow the document share or not
    /// - Parameters:
    ///   - sharedDocument: The document to share
    ///   - allow: A callback to tell the SDK to allow the document share
    ///   - deny: A callback to tell the SDK to deny the document share
    @objc @MainActor func displaySharedDocumentRequested(_ 
                        sharedDocument: LASDKiOS.SharedDocument, 
                        allow: @escaping @Sendable () -> Void,
                        deny: @escaping @Sendable () -> Void
                        ) async

    /// Dismisses the **UIAlertController**
    @objc @MainActor func dismissDialog() async
}
```

* Objective-C
```objective-c
    SWIFT_PROTOCOL("_TtP8LASDKiOS25PushAuthorizationDelegate_")
    @protocol PushAuthorizationDelegate <NSObject>
    /// Our UIAlertController to show to request permission
    @property (nonatomic, strong) UIAlertController * _Nullable documentRequestedAlertController;
    /// This method is designed to ask the consumer if the want to allow the document share or not
    /// param sharedDocument The document to share
    ///
    /// param allow A callback to tell the SDK to allow the document share
    ///
    /// param deny A callback to tell the SDK to deny the document share
    ///
    - (void)displaySharedDocumentRequested:(SharedDocument * _Nonnull)sharedDocument allow:(void (^ _Nonnull)(void))allow deny:(void (^ _Nonnull)(void))deny completionHandler:(void (^ _Nonnull)(void))completionHandler;
    /// Dismisses the <em>UIAlertController</em>
    - (void)dismissDialogWithCompletionHandler:(void (^ _Nonnull)(void))completionHandler;
    @end
```
