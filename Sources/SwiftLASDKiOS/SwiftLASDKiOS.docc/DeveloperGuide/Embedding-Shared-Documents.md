# Embedding-Shared-Documents

By default, **CBA Live Assist** displays shared documents on top of the iOS application. The **CBA Live Assist iOS SDK** allows an application to embed a shared document in its view hierarchy. For example, an application may want to present a text chat window on top of a shared document.

An application can embed shared documents as shown in the following steps:

1.  Create an instance of the iOS SDK's DefaultDocumentViewController class:

UIViewController \*dvc = \[\[DefaultDocumentViewController alloc\] init\];

2.  Add it to the view controller of a window in the application's view hierarchy, ensuring that it displays within that window:

Swift
```swift
let rootViewController = UIApplication.shared.keyWindow?.rootViewController
dvc.view.frame = rootViewController?.view.bounds
dvc.view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
rootViewController?.addChild(dvc)
rootViewController?.view.addSubview(dvc.view)
dvc.didMove(toParent: rootViewController)
```

Objective-C
```objective-c
UIViewController *rootViewController = [UIApplication sharedApplication].keyWindow.rootViewController;
dvc.view.frame = rootViewController.view.bounds;
dvc.view.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
[rootViewController addChildViewController:dvc];
[rootViewController.view addSubview: dvc.view];
[dvc didMoveToParentViewController:rootViewController];
```
3.  Pass this class to startSupport in the configuration:

Swift
```swift
func startSupprt(_ config: Configuration) async {
var config = config
config.documentViewController = dvc
let sdk = try await AssistSDK.startSupport(config)
}
```

Objective-C
```objective-c
NSMutableDictionary* config = [[NSMutableDictionary alloc] init];

Configuration *config = [Configuration alloc];
config.documentViewController = dvc;

[AssistSDK startSupport:config completionHandler:^(AssistSDK *sdk, NSError * error) {}];
```

4.  Re-arrange the view hierarchy when required:

Swift
```swift
// Make 'otherView' appear above shared documents.
let otherView = UIView()
rootViewController.view.bringSubviewToFront(otherView)
```

Objective-C
```objective-c
// Make 'otherView' appear above shared documents.
UIView *otherView=......
[rootViewController.view bringSubviewToFront:otherView];
```

If the application supplies the DefaultDocumentViewController as shown above, then it is the application's responsibility to dismiss it when required. Typically, this would be done when the call ends:

Swift
```swift
func supportCallDidEnd() {
    dvc.willMove(toParent: nil)
    dvc.view.removeFromSuperview()
    dvc.removeFromParent()
}
```

Objective-C
```objective-c
- (void) supportCallDidEnd {
[dvc willMoveToParentViewController:nil];
[dvc.view removeFromSuperview];
[dvc removeFromParentViewController];
}
```

### Setting Shared Document View Constraints

The application may control which portion of the screen is used to display shared documents and images by setting the documentViewConstraints configuration property (see the <doc:Session-Configuration> section); it should set the property to an object of a class conforming to the DocumentViewConstraints protocol. The class has four properties: leftMargin, rightMargin, topMargin, and bottomMargin.

Swift
```swift
class SomeClass: DocumentViewConstraints {

    var topMargin: CGFloat = 50
    var bottomMargin: CGFloat = 50
    var leftMargin: CGFloat = 30
    var rightMargin: CGFloat = 30

}
```

Objective-C
```objective-c

@interface SomeClass : NSObject<DocumentViewConstraints>

@property (nonatomic, assign) float leftMargin;
@property (nonatomic, assign) float rightMargin;
@property (nonatomic, assign) float topMargin;
@property (nonatomic, assign) float bottomMargin;

@end

@implementation SomeClass



@end
```
And to use it:

Swift
```swift

class SomeClass: DocumentViewConstraints {

var topMargin: CGFloat = 50
var bottomMargin: CGFloat = 50
var leftMargin: CGFloat = 30
var rightMargin: CGFloat = 30

    init() {
        var config = Configuration()
        config.documentViewConstraints = self

    //FEED CONFIG TO THE METHOD 
        _ = try await AssistSDK.startSupport(config)
    }
}
```

Objective-C
```objective-c
@interface SomeClass : NSObject<DocumentViewConstraints>

@end

@implementation SomeClass

 @synthesize bottomMargin;
 @synthesize leftMargin;
 @synthesize rightMargin;
 @synthesize topMargin;

- (instancetype)init {

        self.topMargin = 50;
        self.bottomMargin = 50;
        self.leftMargin = 30;
        self.rightMargin = 30;

        Configuration *config = [
            [Configuration alloc]
            // You Will conform to the other arguments in the intializer as well, but we set the delegate here anyways
            documentViewConstraints:self
        ];
}
@end
```
