# AssistSDKDelegate/AssistErrorReporter

Adopting AssistSDKDelegate and implementing its methods enables the application to receive these notifications in Objective-C in swift you will need to adopt the AssistErrorReporter Delegate:

Swift
```swift
func assistSDKDidEncounterError(_ error: LASDKErrors) async
```

Objective-C
```objective-c
  - assistSDKDidEncounterError: (NSNotification) notification
```

Implement this method to receive notifications when **CBA Live Assist** encounters an error. The object of the notification parameter is an LASDKErrors. No keys are defined for the userInfo dictionary, but error reporters may add additional details that could be useful.

A reported LASDKErrors may have its code attribute set to one of the enum case provided in the supplied LASDKErrrors enum. See the <doc:Error-Codes> section.

Swift
```swift
@objc func cobrowseActiveDidChange(to active: Bool)
```

Objective-C
```objective-c
  - cobrowseActiveDidChangeTo: (BOOL) active
```

Implement this method to receive notification when co-browsing becomes active or inactive. The active parameter is YES if co-browsing has started, and NO if it has stopped. You could use this to display something other than the default indication in the user interface.

Swift
```swift
@objc func supportCallDidEnd()
```

Objective-C
```objective-c
  - supportCallDidEnd
```

Implement this method to receive notification of when the support call ends, either by the application calling endSupport, or the agent hanging up the call.. The callback is triggered only when an FCSDK support call is made; it does not occur in co-browse only mode. The callback has no parameters.

Add this delegate using the AssistSDK addDelegate method.

Your application will probably want to adopt this delegate, at least for error reporting.
