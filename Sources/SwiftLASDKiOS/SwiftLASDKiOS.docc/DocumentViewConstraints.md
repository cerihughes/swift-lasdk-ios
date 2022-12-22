# DocumentViewConstraints

Used to set document view constraints for shared documents

## Overview

* Swift
```swift
@objc public protocol DocumentViewConstraints : NSObjectProtocol {
    @objc var topMargin: CGFloat { get set }
    @objc var bottomMargin: CGFloat { get set }
    @objc var leftMargin: CGFloat { get set }
    @objc var rightMargin: CGFloat { get set }
}
```

* Objective-C
```objective-c 
    SWIFT_PROTOCOL("_TtP8LASDKiOS23DocumentViewConstraints_")
    @protocol DocumentViewConstraints <NSObject>
    @property (nonatomic) CGFloat topMargin;
    @property (nonatomic) CGFloat bottomMargin;
    @property (nonatomic) CGFloat leftMargin;
    @property (nonatomic) CGFloat rightMargin;
    @end
```
