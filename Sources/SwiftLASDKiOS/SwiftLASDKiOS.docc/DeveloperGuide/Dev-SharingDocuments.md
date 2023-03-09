# SharingDocuments

As well as receiving shared documents from the agent (see the <doc:Dev-DocumentDelegate> section), applications can use the **CBA Live Assist SDK** to share documents with the agent during a co-browsing session. Acceptable documents are PDFs and images.

Documents shared in this way are represented visually in the same way as documents that are pushed from the agent: PDFs are full screen, and images are in windows that can be dragged, re-sized, or moved.

**Note:** Sharing a document does not actually send the document to the agent, but simply displays the document on the local device, so that both the consumer and the agent can see and co-browse the document.

There are three methods exposed by AssistSDK to handle document sharing:

Swift
```swift
@objc public func shareDocumentUrl(_ documentUrl: URL, delegate consumerShareDelegate: ConsumerDocumentDelegate) async throws
@objc public func shareDocument(formURL string: String, delegate consumerShareDelegate: ConsumerDocumentDelegate) async throws
```

Both the above methods allow sharing a document given its URL. Typically, this would be used to share a document on another machine.

Swift
```swift
@objc public func shareDocument(_ content: Data, mimeType: String, delegate: ConsumerDocumentDelegate?) async throws
```

This method allows sharing a data block containing the document's data. Typically, this would be used to share a document on the local machine. In this case you must supply the mime type (typically @"application/pdf" for PDFs, or something like @"image/jpeg" or @"image/png" for images).

Whichever method is used, the final parameter of the method is an optional instance of a class conforming to ConsumerDocumentDelegate which receives callbacks. The delegate has two methods:

Swift
```swift
@objc func onConsumerDocError(_ document: SharedDocument?, reason reasonStr: String?)
```

Objective-C
```objective-c
- (void)onConsumerDocError:(SharedDocument * _Nullable)document reason:(NSString * _Nullable)reasonStr
```

Called when an error overlay is displayed by **CBA Live Assist** due to the failure to successfully display the shared document for some reason.

Swift
```swift
@objc func onConsumerDocClosed(_ document: SharedDocument?, by whom: DocumentCloseInitiator)
```

Objective-C
```objective-c
- (void)onConsumerDocClosed:(SharedDocument * _Nullable)document by:(enum DocumentCloseInitiator)whom
```

Called when the document is closed. See the <doc:Dev-DocumentDelegate> section for the whom parameter.

**Note:** For a consumer-shared document, the idNumber property of the SharedDocument always has a value of -1.

Errors are handled in two ways:

  - By returning a non-nil Error

  - By invoking the onConsumerError method of a specified ConsumerDocumentDelegate delegate.

The three methods return a non-nil Error if they are invoked when screen-sharing is not active. The delegate onError method is invoked for all other error cases, for example if:

  - An invalid URL is specified;

  - A document cannot be downloaded from the specified URL;

  - An invalid mime type is specified.
