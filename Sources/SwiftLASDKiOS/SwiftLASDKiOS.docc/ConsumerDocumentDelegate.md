# ConsumerDocumentDelegate

This protocol is used to notify the client of any needed Shared Document messages

## Overview

* Swift
```swift
@objc public protocol ConsumerDocumentDelegate : NSObjectProtocol {

    /// Called if there was an issue opening the document.
    /// - Parameters:
    ///   - document: the document that could not be shared.
    ///   - reasonStr: a human readable error message.
    @objc func onError(_ document: LASDKiOS.SharedDocument?, reason reasonStr: String?)

    /// Called if the document was closed.
    /// - Parameters:
    ///   - document: the document that was closed.
    ///   - whom: who closed the document.
    @objc func onClosed(_ document: LASDKiOS.SharedDocument?, by whom: LASDKiOS.DocumentCloseInitiator)
}
```

* Objective-C
```objective-c
    SWIFT_PROTOCOL("_TtP8LASDKiOS24ConsumerDocumentDelegate_")
    @protocol ConsumerDocumentDelegate <NSObject>
    /// Called if there was an issue opening the document.
    /// param document the document that could not be shared.
    ///
    /// param reasonStr a human readable error message.
    ///
    - (void)onError:(SharedDocument * _Nullable)document reason:(NSString * _Nullable)reasonStr;
    /// Called if the document was closed.
    /// param document the document that was closed.
    ///
    /// param whom who closed the document.
    ///
    - (void)onClosed:(SharedDocument * _Nullable)document by:(enum DocumentCloseInitiator)whom;
    @end
```
