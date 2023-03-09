# Integrating with FCSDK

When you call the AssistSDK startSupport method and provide a destination, but no correlationId or sessionToken, in the supportParameters, **CBA Live Assist** automatically starts a voice and video call and a co-browse session with the agent, and automatically ends the call when the application calls AssistSDK endSupport. If you want more control over the voice and video call than this, then you need to start the call using the FCSDK:

Swift
```swift
func fcsdkStart() async {
    uc = await ACBUC.uc(withConfiguration: "", delegate: self)
    await uc?.startSession()
}

func didStartSession(_ uc: ACBUC) async {
    let phone = uc.phone
    let call = phone.createCall(toAddress: "", withAudio: .sendAndReceive, video: .sendAndReceive, delegate: self)
}

func didChange(_ status: ACBClientCallStatus, call: ACBClientCall) async {
    if status == .inCall {
    // Escalate call to co-bowse
    }
}
```

Objective-C
```objective-c
- (void) start {
    [ACBUC ucWithConfiguration:@"" delegate:self completionHandler:^(ACBUC * uc) {
        [uc startSession];
    }];
}

- (void)didStartSession:(ACBUC *)uc completionHandler:(void (^)(void))completionHandler {
    ACBClientPhone *phone = uc.phone;
    ACBClientCall *call = [phone createCallToAddress:@"" withAudio:ACBMediaDirectionSendAndReceive video:ACBMediaDirectionSendAndReceive delegate:self completionHandler:^(ACBClientCall * call) {}];
}

- (void) didChange:(enum ACBClientCallStatus)status call:(ACBClientCall *)call completionHandler:(void (^)(void))completionHandler {
    if (status) == ACBClientCallStatusInCall {
        // Escalate call to co-bowse
    }
}
```

After the call is connected, you need to escalate that call to co-browse (see the <doc:Session-Configuration> section). In order to control the call while it is in progress, the application saves the ACBClientCall object returned by createCallToAddress, so that it can use it when needed. For convenience of illustration, self represents the two delegates which receive information on the progress of session creation and call setup.

See the ***FCSDK Developer Guide*** for more details of how to set up a call, and in particular, of how to obtain a session token to use as the sessionId. It also gives details of what call control features are available and how to use them.
