# DocumentDelegate

A protocol used to inform the client of shared document information

## Overview

* Swift
```swift
@objc public protocol DocumentDelegate : NSObjectProtocol {

    /// Called if there was an issue opening the document.
    /// - Parameters:
    ///   - document: the document that could not be shared.
    ///   - reasonStr: a human readable error message.
    @objc optional func onError(_ document: LASDKiOS.SharedDocument, reason reasonStr: String)

    /// Called if the document was closed.
    /// - Parameters:
    ///   - document: the document that was closed.
    ///   - whom: who closed the document.
    @objc optional func onClosed(_ document: LASDKiOS.SharedDocument, by whom: LASDKiOS.DocumentCloseInitiator)

    /// Called if the document was opened after being pushed by an agent.
    /// - Parameter document: the document that was opened.
    @objc optional func onOpened(_ document: LASDKiOS.SharedDocument)
}
```

* Objective-C
```objective-c
    SWIFT_PROTOCOL("_TtP8LASDKiOS16DocumentDelegate_")
    @protocol DocumentDelegate <NSObject>
    @optional
    /// Called if there was an issue opening the document.
    /// param document the document that could not be shared.
    ///
    /// param reasonStr a human readable error message.
    ///
    - (void)onError:(SharedDocument * _Nonnull)document reason:(NSString * _Nonnull)reasonStr;
    /// Called if the document was closed.
    /// \param document the document that was closed.
    ///
    /// param whom who closed the document.
    ///
    - (void)onClosed:(SharedDocument * _Nonnull)document by:(enum DocumentCloseInitiator)whom;
    /// Called if the document was opened after being pushed by an agent.
    /// param document the document that was opened.
    ///
    - (void)onOpened:(SharedDocument * _Nonnull)document;
    @end
```
