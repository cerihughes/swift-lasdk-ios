# Form Filling

One of the main reasons for a consumer to ask for help, or for an agent to request a co-browse, is to enable the agent to help the consumer to complete a form which is displayed on their device. The agent can do this whenever a **CBA Live Assist** co-browse session is active, without further intervention from the application, but there are some constraints on how forms should be designed.

The **CBA Live Assist SDK** automatically detects form fields represented by UIButton, UISlider, UISwitch, UIStepper, or UIDatePicker controls, and relays these forms to the agent so that the agent can fill in values for the user. You must provide each element with a unique Label attribute, either in the *Interface Builder* or programmatically (if you are adding the controls programmatically).

The SDK automatically prevents the agent from filling in the field if the secureTextEntry attribute is set to true, or **Secure** is specified in the Interface Builder.

**Note:** While the SDK prevents these fields from being presented to the agent as fillable form data, it does not prevent them from being visible as part of the co-browse. You can hide them by adding the appropriate tag or permission to the control (see the <doc:Permissions> section).

### Excluding Elements from Co-browsing

When an agent is co-browsing a form, you may not want the agent to see every control on the form. Some may be irrelevant, and some may be private to the consumer.

In the **CBA Live Assist iOS SDK**, you can mark the UI element with a specific tag value. Do this in Xcode by opening the *Attribute Inspector*, then opening the *View* panel for the UI elements to exclude and entering them in the **Tag** field:

<!--![image_4.png](./image_4.png)-->

The tag value is an arbitrary numeric value. The application can hide or mask all controls with that tag value by passing it in the hidingTags or maskingTags members of the supportParameters when it calls startSupport (see the <doc:Session-Configuration> section).

Use of a unique tag value to obscure elements

In this scenario, the same tag value is used to mark all the elements that need to be obscured; these elements appear on the agent console as black rectangles. To do this, submit the single tag value as an argument of the hidingTags member of the supportParameters:

**Note:** You may use multiple tags to hide multiple views.

Swift
```swift
let tags = [100, 101, 102]
var config = Configuration()
config.hidingTags = tags
let sdk = try await AssistSDK.startSupport(config)
```

Objective-C
```objective-c
NSMutableArray *tags = [[NSMutableArray new] initWithObjects:[NSNumber numberWithInt: 100], [NSNumber numberWithInt: 101], [NSNumber numberWithInt: 102], nil];

Configuration *config = [
    [Configuration alloc]
    // You Will conform to the other arguments in the intializer as well, but we set the delegate here anyways
hidingTags: tags
];

[AssistSDK startSupport:config completionHandler:^(AssistSDK *sdk, NSError * error) {}];
```

Masking elements

In addition to obscuring elements with black boxes, you can also mask elements using the maskingTags configuration property (see the <doc:Session-Configuration> section); in this case the masked elements appear as solid rectangles in the agent console. By default, the rectangles appear black in the agent console, but this color can be changed using the maskColor configuration property. Like hidingTags, the value of the maskingTags property must be an object of type NSSet, which contains objects of type NSNumber that are constructed from integers. The value of the maskColor property must be an object of type UIColor:

Swift
```swift
let tags = [100, 101, 102]
var config = Configuration()
config.maskingTags = tags
config.maskColor = UIColor.blue
let sdk = try await AssistSDK.startSupport(config)
```

Objective-C
```objective-c
NSMutableArray *tags = [[NSMutableArray new] initWithObjects:[NSNumber numberWithInt: 100], [NSNumber numberWithInt: 101], [NSNumber numberWithInt: 102], nil];

Configuration *config = [
    [Configuration alloc]
    // You Will conform to the other arguments in the intializer as well, but we set the delegate here anyways
maskingTags: tags,
maskingColor: UIColor.blueColor
];

[AssistSDK startSupport:config completionHandler:^(AssistSDK *sdk, NSError * error) {}];
```

**Note:** The sub-elements of any hidden or masked element are also implicitly hidden or masked.

For more detailed control over element visibility, see the <doc:Permissions> section.

**Note:** If you are using a UIWebView or WKWebView, and using HTML elements on that web view, you can use the methods described in the ***CBA Live Assist Web Developer Guide*** to mask individual elements, or you can use the above techniques to mask the whole page. You can also set permissions on the elements (see the <doc:Permissions> section). However, if the elements are contained in a iframe which is contained in an HTML page which is loaded into a UIWebView or WKWebView, they will not be masked.
