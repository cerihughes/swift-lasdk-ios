# Accepting Self-Signed Certificates

By default, self-signed security certificates are rejected by the iOS SDK. If you wish to accept self signed certificates, set the acceptSelfSignedCerts configuration parameter to true (see the <doc:Session-Configuration> section).

We recommend that you restrict this mode to debug builds. By default, Xcode uses the debug mode for a local run, but uses the release mode for anything pushed to the App Store or an enterprise server. Doing this automatically restricts acceptance of self-signed certificates:

Swift
```swift
let config = Configuration()

#if DEBUG
config.acceptSelfSignedCerts: true
#endif

try await AssistSDK.startSupport(config)
```

Objective-C
```objective-c
Configuration *config = [Configuration alloc];

#ifdef DEBUG
config.acceptSelfSignedCerts = true;
#endif

[AssistSDK startSupport:config completionHandler:^(AssistSDK *sdk, NSError * error) {}];
```
**Note: CBA Live Assist** *App Transport Security* (ATS) causes all insecure traffic to be blocked or disabled, which includes both HTTP traffic and HTTPS traffic to a server using self-signed certificates. To test or develop against a development installation of the **CBA Live Assist** server, disable ATS by adding the following property to the project plist file:
```HTTP
<key>NSAppTransportSecurity</key>
<dict>
<key>NSAllowsArbitraryLoads</key>
<true/>
</dict>
```
