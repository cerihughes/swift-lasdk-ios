# DocumentDelegate

Adopting DocumentDelegate enables an application to receive notification when the agent sends a document to the consumer:


Swift
```swift
@objc optional func onOpened(_ document: SharedDocument)
```

Objective-C
```objective-c
  - onOpened: (SharedDocument) document
```

Called when the document has been received and displayed.

Swift
```swift
@objc optional func onClosed(_ document: SharedDocument, by: DocumentCloseInitiator)
```

Objective-C
```objective-c
  - onClosed: (SharedDocument) document by: (DocumentCloseInitiator) whom
```

Called when the document is closed. AssistSDKDocumentCloseInitiator is an enumeration with the following members:

Swift
```swift
    case closedByUnknown
    case closedByAgent
    case closedByConsumer
    case closedBySupportEnded
```

Objective-C
```objective-c
  DocumentClosedByUnknown
  DocumentClosedByAgent
  DocumentClosedByConsumer
  DocumentClosedBySupportEnded
```

Swift
```swift
    func onError(_ document: SharedDocument?, reason reasonStr: String?)
```

Objective-C
```objective-c
    onError: (SharedDocument) document reason: (NSString) reasonStr
```

Called if there was a problem displaying the document or URI.

Each callback also has an SharedDocument parameter, which has a close method, allowing the application to close the document programmatically. It also has an idNumber property, allowing received documents to be compared, and a metadata property (a String), which receives any additional information which the agent has associated with the document.

By default, the **CBA Live Assist SDK** displays the document. Acceptable document types are: PDF, and the image formats GIF, PNG, and JPG/JPEG.

**Note:** If the agent pushes a URI, instead of a document, the SDK does not call either the onOpened or onClosed methods; however, if there is a problem opening the URI, it *will* call onError.

Add this delegate using the AssistSDK addDelegate method.
