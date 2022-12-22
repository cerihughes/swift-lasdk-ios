# AnnotationDelegate

This protocol is designed to inform the client of annotation events sent by the **AssistSDK**

## Overview

* Swift
```swift
@objc public protocol AnnotationDelegate : Sendable {
    @objc func assistSDKWillAddAnnotation(_ notification: Notification?)
    @objc func assistSDKDidAddAnnotation(_ notification: Notification?)
    @objc func assistSDKDidClearAnnotations(_ notification: Notification?)
}
```

* Objective-C
```objective-c
    @protocol AnnotationDelegate
    - (void)assistSDKWillAddAnnotation:(NSNotification * _Nullable)notification;
    - (void)assistSDKDidAddAnnotation:(NSNotification * _Nullable)notification;
    - (void)assistSDKDidClearAnnotations:(NSNotification * _Nullable)notification;
    @end
```
