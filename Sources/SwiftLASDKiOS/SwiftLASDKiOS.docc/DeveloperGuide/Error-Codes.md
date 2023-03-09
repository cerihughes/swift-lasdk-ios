# Error Codes

| Code | Value | Meaning |
|-|:-:|-|
| LASDKErrors.calleeNotFound | 20101 | The dialed number could not be found |
| LASDKErrors.calleeBusy | 20102 | The callee was unable to answer the call. |
| LASDKErrors.callCreationFailed | 20103 | The creation of the call failed |
| LASDKErrors.callTimeout | 20104 | The callee did not answer the call within the network’s timeout |
| LASDKErrors.callFailed | 20105 | The call failed to complete |
| LASDKErrors.sessionFailure | 20106 | Failed to establish a Client SDK session for voice and video |
| LASDKErrors.cameraNotAuthorized | 20107 | The user did not give permission to use the device’s camera |
| LASDKErrors.microphoneNotAuthorized | 20108 | The user did not give permission to use the device’s microphone |
| LASDKErrors.assistSessionCreationFailure | 30101 | The Assist session failed to be created |
| LASDKErrors.assistTransportFailure | 30102 | Network error |
| LASDKErrors.assistSessionInProgress | 30103 | There is already a session in use |
| LASDKErrors.assistConsumerDocumentShareFailedNotScreenSharing | 40101 | Attempt to share a screen when screen sharing is not active |
| LASDKErrors.assistSupportEnded | 50101 | The endSupport method was explicitly called to end co-browsing (as opposed to co-browsing being terminated in any other way). |
| LASDKErrors.fcsdkSessionFailure | | FCSDK Failed to start the session. |
| LASDKErrors.fcsdkSystemFailure | | The FCSDK System Failed. |
| LASDKErrors.fcsdkLostConnection | | FCSDK lost WebSocket connection. |
| LASDKErrors.fcsdkDidReceiveCallFailure | | FCSDK failed to make the call. |
| LASDKErrors.fcsdkDidReceiveDialFailure | | FCSDK failed to dial the call. |
| LASDKErrors.unknownMimeType | | When sharing the document there was an unsupported MimeType. |
