# AnnotationDelegate

Adopt the AssistSDKAnnotationDelegate to receive notifications relating to annotations which the agent may send to the consumer. It has three optional methods:

Swift
```swift
@objc func assistSDKWillAddAnnotation(_ notification: Notification?)
```

Objective-C
```objective-c
  - assistSDKWillAddAnnotation: (NSNotification) notification
```

Called when the application receives an annotation from an agent. The application can make changes to the annotation before **CBA Live Assist** displays it. See the <doc:Annotations> section.

Swift
```swift
@objc func assistSDKDidAddAnnotation(_ notification: Notification?)
```

Objective-C
```objective-c
  - assistSDKDidAddAnnotation: (NSNotification) notification
```

Called when the application receives an annotation from an agent, immediately before **CBA Live Assist** displays it. See the <doc:Annotations> section.

Swift
```swift
@objc func assistSDKDidClearAnnotations(_ notification: Notification?)
```

Objective-C
```objective-c
  - assistSDKDidClearAnnotations: (NSNotification) notification
```

Called when an agent clears the annotations. See the <doc:Annotations> section.

You can use this in order to control the display and clearing of annotations which the application receives from the agent (see the <doc:Annotations> section).

Add this delegate using the AssistSDK addDelegate method.
