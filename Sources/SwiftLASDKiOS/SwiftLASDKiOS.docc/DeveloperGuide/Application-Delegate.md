# Application Delegate

An application can receive notification of certain actions that occur within **CBA Live Assist** and take control of the response to them. The following sections discuss what notifications the application can receive and what operations are available.

The application can add delegates conforming to the following protocols to the configuration when it calls AssistSDK.startSupport:

  - ScreenShareRequestedDelegate

  - AgentCobrowseDelegate

  - ConnectionStatusDelegate

  - PushAuthorizationDelegate

It can only add a single instance of each of these delegates to the configuration (see the <doc:Session-Configuration> section).

It can add delegates conforming to the following protocols using the AssistSDK.addDelegate method:

  - AssistSDKDelegate

  - DocumentDelegate

  - AnnotationDelegate

AssistSDK supports multiple delegates for any of these protocols. Delegates registered with AssistSDK must conform to at least one of them. If they do not, then they are not added to the delegate set. The delegates are not ordered, and the order in which they receive messages is not defined. Multiple delegates can support the same or different protocols. The application manages the registered delegates by calling the addDelegate and removeDelegate class methods.

In the following code, the TabViewController is the AssistErrorReporter which is a Swift Based App delegate only for error handling; it uses addDelegate to register itself, and receives calls to two of its error:

Swift
```swift
class TabViewController: AssistErrorReporter {

    func start(_ config: Configuration) async {
        AssisSDK.addDelegate = self
        let sdk = try await AssistSDK.startSupport(config)
    }

    func endSupport() async {
        
    }

    func assistSDKDidEncounterError(_ error: LASDKErrors) {
        switch error {
        case .fcsdkSessionFailure:
            break
        case .fcsdkSystemFailure:
            break
        case .fcsdkLostConnection:
            break
        case .fcsdkDidReceiveCallFailure:
            break
        case .fcsdkDidReceiveDialFailure:
            break
        case .calleeNotFound:
            break
        case .assistSessionCreationFailure:
            break
        case .assistConsumerDocumentShareFailedNotScreenSharing:
            break
        case .assistSupportEnded:
            break
        case .calleeBusy:
            break
        case .callCreationFailed:
            break
        case .callTimeout:
            break
        case .callFailed:
            break
        case .sessionFailure:
            break
        case .cameraNotAuthorized:
            break
        case .microphoneNotAuthorized:
            break
        case .assistTransportFailure:
            break
        case .assistSessionInProgress:
            break
        case .unknownMimeType:
            break
        default:
            break
        }
    }

}
```


In the following code, the TabViewController is the AssistSDKDelegate; it uses addDelegate to register itself, and receives calls to two of its error notifications. The Method - (void) assistSDKDidEncounterError:(NSNotification*) notification {} on the delegate is intended for use only in Objective-C based apps:

Objective-C
```objective-c
@interface TabViewController : UITabBarController<AssistSDKDelegate>
@end

@implementation TabViewController {
}

- (void) start : (NSString*) server {
[AssistSDK addDelegate:self];
[AssistSDK startSupport:config completionHandler:^(AssistSDK *sdk, NSError * error) {}];
}

- (void) supportCallDidEnd {

}
- (void) assistSDKDidEncounterError:(NSNotification*) notification {
[self reportError:[notification object]];

}

- (void) reportError:(NSError*) error {

}

@end
```
Each NSNotification name is the LASDKErrors case for the inteneded error to report. So as in where the SDK is consumed in a Swift based app a nice swift enum is provided; in an Objective-C based app we now provide you wuth an object notification of the Swift enum's Error case **(i.e. LASDKErrors.assistTransportFailure or for errors with integer error codes - assistSessionCreationFailure = 30101)**

**Note:** The SDK defines another delegate protocol (ConsumerDocumentDelegate), which is passed to the document sharing methods (see the <doc:Sharing-Documentat> section).
