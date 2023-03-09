# Annotations

By default the **CBA Live Assist SDK** displays any annotations which the application receives on an overlay, so that the consumer can see them together with their own screen. Normally an application needs to do nothing further, but if it needs to receive notifications when an annotation arrives, it can define a class which conforms to the AnnotationDelegate protocol and add it to AssistSDK using addDelegate:

Swift
```swift
class AnnotationsController: AnnotationDelegate {

    func start() {
        AssistSDK.addDelegate(self)
    }

}
```

Objective-C
```objective-c
@interface AnnotationController : AnnotationDelegate
@end

@implementation AnnotationController {
}

- (void) start : (NSString*) server {
[AssistSDK addDelegate:self];
}

@end
```

The AnnotationDelegate offers:

  - Notification of new annotations received

  - Notification of annotations cleared

See the <doc:Dev-AnnotationDelegate> section.

### Notification of Annotations Received

The two methods assistSDKWillAddAnnotation and assistSDKDidAddAnnotation are called when the agent sends an annotation to the consumer. The notification parameter for both methods has an object which is an NSMutableDictionary with the following members:

| Key                           | Value Class  | Description                                                           |
| ----------------------------- | ------------ | --------------------------------------------------------------------- |
| kASDKSVGPathKey               | UIBezierPath | The path which will be added as an annotation                         |
| kASDKSVGLayerKey              | CAShapeLayer | The layer containing the annotation which will be displayed           |
| kASDKSVGPathStrokeKey         | UIColor      | The color of the annotation                                           |
| kASDKSVGPathStroke WidthKey   | NSNumber     | A number giving the width of the line of the annotation               |
| kASDKSVGPathStroke OpacityKey | NSNumber     | A number between 0.0 and 1.0 indicating the opacity of the annotation |

The userInfo dictionary is used for ancillary data.

The CAShapeLayer is created and initialized from the other attributes between the calls to the Will and Did callbacks. Any values changed in the Will callback are used in the initialization. To change the color of the annotation to purple:

Swift
```swift
func assistSDKWillAddAnnotation(_ notification: Notification?) {
    var dic = notification?.object as? [AnyHashable : Any]
    dic?["kASDKSVGPathStrokeKey"] = UIColor.purple
}
```

Objective-C
```objective-c
- (void)assistSDKWillAddAnnotation:(NSNotification * _Nullable)notification {
NSMutableDictionary* dic = [notification object];
dic[@"kASDKSVGPathStrokeKey"] = [UIColor purpleColor];
}
```
To affect the display in the Did callback, the application must manipulate the CAShapeLayer directly:

Swift
```swift
func assistSDKDidAddAnnotation(_ notification: Notification?) {
    var dic = notification?.object as? [AnyHashable : Any]
    let layer = dic?["kASDKSVGLayerKey"] as? CAShapeLayer
    let purple = UIColor.purple.cgColor
    layer?.strokeColor = purple
}
```

Objective-C
```objective-c
- (void)assistSDKDidAddAnnotation:(NSNotification * _Nullable)notification {

NSMutableDictionary* dic = [notification object];
CAShapeLayer* layer = dic[@"kASDKSVGLayerKey"];
CGColor* purple = [[UIColor purpleColor] CGColor];

[layer setStrokeColor:purple];
}
```

### Notification of Annotations Cleared

To get notification when the agent clears the annotations, implement the assistSDKDidClearAnnotations method.

The object of the notification parameter is an array of CAShapeLayer instances which have been cleared. The dictionary used to create the layer is no longer available, but the layer could contain metadata placed on it in the assistSDKDidAddAnnotation callback:

Swift
```swift
func assistSDKDidAddAnnotation(_ notification: Notification?) {
    var dic = notification?.object as? [AnyHashable : Any]
    var layer = dic?["kASDKSVGLayerKey"] as? CAShapeLayer
    layer?.setValue("agent1", forKey: "agentName")
}

func assistSDKDidClearAnnotations(_ notification: Notification?) {
    let layer = notification?.object as? CAShapeLayer
    let agent = layer?.value(forKey: "agentName") as? String
    print("Layer from \(agent ?? "") cleared")
}
```

Objective-C
```objective-c
- (void)assistSDKDidAddAnnotation:(NSNotification * _Nullable)notification {
NSMutableDictionary* dic = [notification object];
CAShapeLayer* layer = dic[@"kASDKSVGLayerKey"];
[layer setValue:@"agent1" forKey:@"agentName"];
}

- (void) assistSDKDidClearAnnotations:(NSNotification * _Nullable)notification {
CAShapeLayer* layer = [notification object];
NSString* agent = [layer valueForKey: @"agentName"];
NSLog(@"Layer from %@ cleared", agent);
}
```
