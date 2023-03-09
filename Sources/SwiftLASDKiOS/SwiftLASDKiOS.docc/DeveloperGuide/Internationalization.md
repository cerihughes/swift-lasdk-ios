# Internationalization

Currently, there is no internationalization support in the **CBA Live Assist SDK** . We suggest that the application should supply its own implementations of those delegates which result in a default UI, and use them to show its own (internationalized) UI:

Swift
```swift
func cobrowseActiveDidChange(to active: Bool) {
    if active {
        displayCobrowserNotification()
    } else { 
        removeCobrowseNotification()
    }
}

func displayCobrowserNotification() {
    let message = "cobrowse-message"
}

func removeCobrowseNotification() {
}
```

Objective-C
```objective-c
- (void) cobrowseActiveDidChangeTo:(BOOL)active {
    if (active) {
        [self displayCobrowseNotification];
    } else {
        [self removeCobrowseNotification];
    }
}

- (void) displayCobrowseNotification {
    NSString message = NSLocalizedString(@"cobrowse-message", nil);
}

- (void) removeCobrowseNotification {
}
```

where we assume that the internationalized text for the co-browse message in the current language exists. The application is responsible for displaying the internationalized string to the user in whatever way it likes.

The following delegates show a default UI, and an internationalized application needs to implement them:

  - AssistSDKDelegate

  - ASDKScreenShareRequestedDelegate

  - ASDKPushAuthorizationDelegate

  - ASDKAgentCobrowseDelegate
