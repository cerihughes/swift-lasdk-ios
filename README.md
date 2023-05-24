# Swift LASDK iOS

## System Minimum Requirements ##
* Xcode 13
* Monterey 12.1
* swift-tools-version:5.5
* iOS 13

## Binaries
| **Platform / arch** | arm64  | x86_x64 |
|---------------------|--------|---------|
| **iOS (device)**    |   ✅   |   N/A   |
| **iOS (simulator)** |   ✅   |    ✅   |


#### Please Follow this repository for the latest SDK notifications.


## Documentation

We are happy to introduce *DocC* documentation for LASDKiOS. Simply build the documentation with **Command + Control + Shift + D** in your app and have all the documentation that you need right in Xcode.

## Version Changes

## Swift Package Manager ##

    1. In your Xcode Project, select File > Swift Packages > Add Package Dependency.
    2. Follow the prompts using the URL for this repository
    3. Choose which version you would like to checkout(i.e. 2.0.0)
    4. Make sure the binary is linked in your Xcode Project via the target ``Target -> Build Phases -> Linked Binary``.

 If you want to depend on LASDKiOS in your own project using SPM, it's as simple as adding a `dependencies` clause to your `Package.swift`:


```swift
dependencies: [
    .package(url: "https://github.com/cbajapan/swift-lasdk-ios.git", from: "2.0.0")
]
```

## CocoaPods ##

Starting in version 2.0.0 of LASDK we are supporting CocoaPods as a delivery mechanism.

In order to use our CocoaPod please follow the following instructions.

1. Navigate to your project 
2. Run `pod init`
3. Run `open -a Xcode Podfile`
4. Edit the Podfile as indicated below

```
source 'https://github.com/cbajapan/swift-lasdk-ios'

target 'CBAFusion' do
  # Comment the next line if you don't want to use dynamic frameworks
  use_frameworks!

  # Pods for CBAFusion
pod 'LASDKiOS', '~> 2.0.0'
pod 'FCSDKiOS', '~> 4.2.2'
pod 'WebRTC', '~> 110.0.0'
end
```
5. Close the Podfile
6. Run `pod install`
7. You now will use the **.xcworkspace** instead of **.xcodeproj** as a project source.

**NOTE:** if you have trouble installing or updating the CocoaPod, you may have an issue with the local pod repo.

*If that is the case please try running the following Pod Commands*

```
sudo rm -fr ~/.cocoapods/repos/cbajapan-swift-lasdk-ios
pod setup
pod install
```

Afterwards you can run the install or update command again

```
pod install
```

## Import the SDK into your project ##
Swift
```swift
import LASDKiOS
````
Objective-C
```swift
@import LASDKiOS;
```

## Getting Started
**Please Read our DocC Documentation for more information**

[Using LASDKiOS](https://github.com/cbajapan/swift-lasdk-ios/blob/main/Sources/SwiftLASDKiOS/SwiftLASDKiOS.docc/DeveloperGuide/Using%20LASDKiOS.md 'Using LASDKiOS')

[Session Configuration](https://github.com/cbajapan/swift-lasdk-ios/blob/main/Sources/SwiftLASDKiOS/SwiftLASDKiOS.docc/DeveloperGuide/Session-Configuration.md 'Session Configuration')

[Creating a Session](https://github.com/cbajapan/fcsdk-ios/blob/main/Sources/SwiftFCSDKiOS/SwiftFCSDKiOS.docc/CreatingSession.md 'Creating Session')

[Consumer Session Creation](https://github.com/cbajapan/swift-lasdk-ios/blob/main/Sources/SwiftLASDKiOS/SwiftLASDKiOS.docc/DeveloperGuide/Consumer-Session-Creation.md 'Consumer Session Creation]')

[WebSocket Reconnection Control](https://github.com/cbajapan/swift-lasdk-ios/blob/main/Sources/SwiftLASDKiOS/SwiftLASDKiOS.docc/DeveloperGuide/WebSocket-Reconnection-Control.md 'WebSocket Reconnection Control')

[Snapshots](https://github.com/cbajapan/swift-lasdk-ios/blob/main/Sources/SwiftLASDKiOS/SwiftLASDKiOS.docc/DeveloperGuide/Snapshots.md 'Snapshots')

[Self-Signed Certificates](https://github.com/cbajapan/swift-lasdk-ios/blob/main/Sources/SwiftLASDKiOS/SwiftLASDKiOS.docc/DeveloperGuide/Self-Signed-Certs.md 'Self-Signed Certificates')

[Permissions](https://github.com/cbajapan/swift-lasdk-ios/blob/main/Sources/SwiftLASDKiOS/SwiftLASDKiOS.docc/DeveloperGuide/Permissions.md 'Permissions')

[Pause and Resume CoBrowse](https://github.com/cbajapan/swift-lasdk-ios/blob/main/Sources/SwiftLASDKiOS/SwiftLASDKiOS.docc/DeveloperGuide/Pause-Resume-CoBrowse.md 'Pause and Resume CoBrowse')

[Password Fields](https://github.com/cbajapan/swift-lasdk-ios/blob/main/Sources/SwiftLASDKiOS/SwiftLASDKiOS.docc/DeveloperGuide/Password-Fields.md 'Password Fields')

[LA without voice and video](https://github.com/cbajapan/swift-lasdk-ios/blob/main/Sources/SwiftLASDKiOS/SwiftLASDKiOS.docc/DeveloperGuide/LA-without-voice-video.md 'LA without voice and video')

[Internationalization](https://github.com/cbajapan/swift-lasdk-ios/blob/main/Sources/SwiftLASDKiOS/SwiftLASDKiOS.docc/DeveloperGuide/Internationalization.md 'Internationalization')

[Integrating with FCSDK](https://github.com/cbajapan/swift-lasdk-ios/blob/main/Sources/SwiftLASDKiOS/SwiftLASDKiOS.docc/DeveloperGuide/Integrating-FCSDK.md 'Integrating with FCSDK')

[Informing the Agent of the CorrelationId](https://github.com/cbajapan/swift-lasdk-ios/blob/main/Sources/SwiftLASDKiOS/SwiftLASDKiOS.docc/DeveloperGuide/Inform-CID.md 'Informing the Agent of the CorrelationId')

[IPv6](https://github.com/cbajapan/swift-lasdk-ios/blob/main/Sources/SwiftLASDKiOS/SwiftLASDKiOS.docc/DeveloperGuide/IPv6.md 'IPv6')

[Form Filling](https://github.com/cbajapan/swift-lasdk-ios/blob/main/Sources/SwiftLASDKiOS/SwiftLASDKiOS.docc/DeveloperGuide/Form-Filling.md 'Form Filling')

[Error Codes](https://github.com/cbajapan/swift-lasdk-ios/blob/main/Sources/SwiftLASDKiOS/SwiftLASDKiOS.docc/DeveloperGuide/Error-Codes.md 'Error Codes')

[Ending a Session](https://github.com/cbajapan/swift-lasdk-ios/blob/main/Sources/SwiftLASDKiOS/SwiftLASDKiOS.docc/DeveloperGuide/Ending-A-Session.md 'Ending a Session')

[Embedding Shared Documents](https://github.com/cbajapan/swift-lasdk-ios/blob/main/Sources/SwiftLASDKiOS/SwiftLASDKiOS.docc/DeveloperGuide/Embedding-Shared-Documents.md 'Embedding Shared Documents')

[During a Session](https://github.com/cbajapan/swift-lasdk-ios/blob/main/Sources/SwiftLASDKiOS/SwiftLASDKiOS.docc/DeveloperGuide/During-Session.md 'During a Session')

[ScreenShareRequestDelegate](https://github.com/cbajapan/swift-lasdk-ios/blob/main/Sources/SwiftLASDKiOS/SwiftLASDKiOS.docc/DeveloperGuide/Dev-ScreenShareRequestDelegate.md 'ScreenShareRequestDelegate')

[Sharing Documents](https://github.com/cbajapan/swift-lasdk-ios/blob/main/Sources/SwiftLASDKiOS/SwiftLASDKiOS.docc/DeveloperGuide/Dev-SharingDocuments.md 'Sharing Documents')

[PushAuthorizationDelegate](https://github.com/cbajapan/swift-lasdk-ios/blob/main/Sources/SwiftLASDKiOS/SwiftLASDKiOS.docc/DeveloperGuide/Dev-PushAuthorizationDelegate.md 'PushAuthorizationDelegate')

[DocumentDelegate](https://github.com/cbajapan/swift-lasdk-ios/blob/main/Sources/SwiftLASDKiOS/SwiftLASDKiOS.docc/DeveloperGuide/Dev-DocumentDelegate.md 'DocumentDelegate')

[ConnectionStatusDelegate](https://github.com/cbajapan/swift-lasdk-ios/blob/main/Sources/SwiftLASDKiOS/SwiftLASDKiOS.docc/DeveloperGuide/Dev-ConnectionStatusDelegate.md 'ConnectionStatusDelegate')

[AnnotationDelegate](https://github.com/cbajapan/swift-lasdk-ios/blob/main/Sources/SwiftLASDKiOS/SwiftLASDKiOS.docc/DeveloperGuide/Dev-AnnotationDelegate.md 'AnnotationDelegate')

[AgentCobrowseDelegate](https://github.com/cbajapan/swift-lasdk-ios/blob/main/Sources/SwiftLASDKiOS/SwiftLASDKiOS.docc/DeveloperGuide/Dev-AgentCobrowseDelegate.md 'AgentCobrowseDelegate')

[Cookies](https://github.com/cbajapan/swift-lasdk-ios/blob/main/Sources/SwiftLASDKiOS/SwiftLASDKiOS.docc/DeveloperGuide/Cookies.md 'Cookies')

[AssistErrorReporter](https://github.com/cbajapan/swift-lasdk-ios/blob/main/Sources/SwiftLASDKiOS/SwiftLASDKiOS.docc/DeveloperGuide/AssistSDKDelegate-AssistErrorReporter.md 'AssistErrorReporter')

[Application Delegate](https://github.com/cbajapan/swift-lasdk-ios/blob/main/Sources/SwiftLASDKiOS/SwiftLASDKiOS.docc/DeveloperGuide/Application-Delegate.md 'Application Delegate')

[Annotations](https://github.com/cbajapan/swift-lasdk-ios/blob/main/Sources/SwiftLASDKiOS/SwiftLASDKiOS.docc/DeveloperGuide/Annotations.md 'Annotations')

[Allow Disallow CoBrowse](https://github.com/cbajapan/swift-lasdk-ios/blob/main/Sources/SwiftLASDKiOS/SwiftLASDKiOS.docc/DeveloperGuide/Allow-Disallow-CoBrowse.md 'Allow Disallow CoBrowse')

[Alerts Dialogs](https://github.com/cbajapan/swift-lasdk-ios/blob/main/Sources/SwiftLASDKiOS/SwiftLASDKiOS.docc/DeveloperGuide/Alerts-Dialogs.md 'Alerts Dialogs')

[Developer Guide](https://github.com/cbajapan/swift-lasdk-ios/blob/main/Sources/SwiftLASDKiOS/SwiftLASDKiOS.docc/DeveloperGuide/DeveloperGuide.md 'Developer Guide')

[Migrating from the Legacy SDK](https://github.com/cbajapan/swift-lasdk-ios/blob/main/Sources/SwiftLASDKiOS/SwiftLASDKiOS.docc/MigrationGuide/MigratingFromLegacySDK.md 'Learn Markdown')


