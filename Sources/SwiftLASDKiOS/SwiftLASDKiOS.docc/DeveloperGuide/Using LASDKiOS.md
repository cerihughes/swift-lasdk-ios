# Using LASDKiOS

This guide describes the **Fusion Live Assist** solution from a developer integration and impact point of view. We assume that the reader is familiar with iOS, XCode, and Objective-C.

**Fusion Live Assist** provides voice and video calling from a consumer to an agent, along with co-browsing, and document push by the agent, and remote control and annotation of the consumer's screen by the agent. See the ***CBA Live Assist Overview and Installation Guide*** for details of what that means in practice.

For ease of integration and development, **Fusion Live Assist** uses the **Fusion Client SDK** for voice and video support, while exposing a simple API for co-browsing. When developing using the **CBA Live Assist SDK**, you use the **Fusion Client SDK** to set up the call, and the **CBA Live Assist SDK** for co-browsing. You therefore need at least a basic understanding of the **Fusion Client SDK** in order to develop using **CBA Live Assist** (see the ***FCSDK Developer Guide***).

This Developer Guide gives information on integrating the **Fusion Live Assist SDK** into an *iOS* application, and how to use it to provide the co-browsing functions to a consumer.

References:

**FCSDK Developer Guide**, obtained from CBA product documentation

**FCSDK Administration Guide**, obtained from CBA product documentation

### Using CBA Live Assist as a Swift Package

We can fetch AssistSDK from GitHub and use it in our project by doing the following:
```
1. In your Xcode Project, select File > Swift Packages > Add Package Dependency.
2. Follow the prompts using this url for LASDK- https://github.com/cbajapan/swift-lasdk-ios.git
3. Choose which version you would like to checkout
```

Or you can clone the Package and use it locally using `git clone`. **This is more work and not recommended**

To set up a project using the Swift Package we want to depend on the Swift Package at the root level of your project. 

1.   Open your Xcode project and drag the unzipped Swift Package into the root level of your project, typically you can do this directly under the project as shown in the image below

2.   We want to make sure that the Swift Package has the little arrow next to the package in the directory window. If yours does not look like this, close the Xcode project and re-open it. This is a known Xcode bug.

4.   Click the **General** tab of your Target, and expand the _Frameworks, Libraries, and Embedded Content_ section by clicking on the title.

4.   Click the **+** button; the file explorer displays.

5.   Select the LASDKiOS Library and press add

6.   Done, your project is now ready to use Fusion Client SDK

### Using LASDK Swift Package in a Framework or Static Library

***If you are interested in building a Static Library instead of a Framework the process is the same***

LASDK Swift Package contains 1 dependency and 1 binary target

1. Binary Target- LASDKiOS
2. Binary Target- FCSDKiOS
3. Binary Target- CBARealTime

FCSDK-iOS consists of 3 Frameworks
1. LASDKiOS
2. FCSDKiOS
3. CBARealTime

The nature of Frameworks and Static Libraries cause us to use them in a very specific way. Apple will not allow Embedded Frameworks to be released on the App Store in iOS. So that means if you try and embed these 2 frameworks into your framework, it will inevitably fail. What you want to do when it comes to depending on a framework within your framework is to link the child framework to the parent framework, but **DO NOT EMBED THEM**. This will result in the External Symbols being linked, but not the internal symbols. So, if you try to place the framework you created in your application, you will get several errors saying that there are symbols missing. How can this be resolved? You need to import those same 2 frameworks you depend on in your framework into the Application you are building. 

This seems like a lot of work, so we have done most of it for you with our Swift Package.

All you need to do is import the Swift Package into your framework as described above. However, in order to use the Framework you are developing in an iOS application there are a couple of steps you will need to follow.

We basically have 2 options: 
1. Do as described above and import your framework that depends on AssistSDK along with AssistSDK into the iOS application. 
OR
2. Let Swift Package Manager handle all of that for you.

**We will describe option 2, as it is our recommendation.**

You will want to create a Swift Package in order to distribute your XCFramework.

1. Open Terminal
2. Create a directory - you can name it something like `my-framework-kit` with `mkdir MY_DIRECTORY`
2. Move into that directory with `cd my-framework-kit`
3. Create the Swift Package with `swift package init`
4. Open `Package.swift` in Xcode
5. Make sure that your XCFramework is in the root directory of the Swift Package, so in our case, it should be located in `my-framework-kit`

**Now, with Package.swift open make sure it looks like this**
```swift
// swift-tools-version:5.3
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "my-framework-kit",
    products: [
        .library(
            name: "my-framework-kit",
            type: .static,
            targets: ["my-framework-kit"]),
    ],
    dependencies: [
        .package(name: "LASDKiOS", url: "https://github.com/cbajapan/swift-lasdk-ios.git", .exact("2.0.0"))
    ],
    targets: [
        .target(
            name: "my-framework-kit",
            dependencies: [
                "my-framework",
                .product(name: "LASDKiOS", package: "LASDKiOS")
            ]),
        .binaryTarget(name: "my-framework", path: "my-framework.xcframework")
    ]
)
```
I will describe what this file does - What we are mostly interested in is the **Package**

Inside this initializer, we have 4 properties:
1. Name
2. Products
3. Dependencies
4. Target

* Name is not very important, but typically this is the name of the directory you made
* Products consists of the Libraries name; we also need to specify this Library as a Static Library, and we want to tell it about our Target that we define in **Packages** final property.
* Dependencies are any code that you want to bring in from a url that is an internal or external resource, so basically, other Swift Packages. Here we are depending on `FCSDK-iOS`
* Finally, our Targets involves the target we want our package to know about and its dependencies. So here we are depending on our `my-framework.xcframework` binary locally, and then we need to tell the target about the package dependency we fetch from *Github*. We also need to tell our target where our **XCFramework** is located in the `binaryTarget`


Once we create our Swift Package, as describe above, we have 2 options:

1. Depend on it Locally as Described in - **The use of Swift Package starting in version 3.3.21** 
2. Commit our Swift Package to a git repo and have our iOS client fetch it from there.
We can fetch remote code from our iOS Project by doing the following:
```
1. In your Xcode Project, select File > Swift Packages > Add Package Dependency.
2. Follow the prompts using the URL for this repository
3. Choose which version you would like to checkout (i.e. 2.0.0)
```
### Creating an XCFramework

In order to create an XCFramework that supports a variety of Architectures we recommend using a shell script to Archive your project's target and then create the XCFramework. So in the root of your Framework or Static Library Create a file and call it something like `build.sh` 

Here is an example of what `build.sh` need to have inside of it

**Note**
You need to make sure that in your project in the Xcode Build Settings these 2 settings are set accordingly
`SKIP_INSTALL=NO`
`BUILD_LIBRARY_FOR_DISTRIBUTION=YES`

```
#!/bin/zsh


xcodebuild archive \
-project YourProject.xcodeproj \
-scheme YourProjectTarget \
-archivePath build/device.xcarchive \
-destination "generic/platform=iOS" \
STRIP_STYLE=non-global \
COPY_PHASE_STRIP=YES \
STRIP_INSTALLED_PRODUCT=YES \
ENABLE_BITCODE=NO \
IPHONEOS_DEPLOYMENT_TARGET=13.0

# Simulator builds don't have bitcode abilities
xcodebuild archive \
-project YourProject.xcodeproj \
-scheme YourProject \
-archivePath build/simulator.xcarchive \
-destination "generic/platform=iOS Simulator" \
STRIP_STYLE=non-global \
COPY_PHASE_STRIP=YES \
STRIP_INSTALLED_PRODUCT=YES \
IPHONEOS_DEPLOYMENT_TARGET=13.0

#Time to create an XCFramework with device and simulator for a Static Library
xcodebuild -create-xcframework \
-library build/device.xcarchive/Products/usr/local/lib/libYourFramework.a \
-headers build/device.xcarchive/Products/usr/local/include \
-library build/simulator.xcarchive/Products/usr/local/lib/libYourFramework.a \
-headers build/simulator.xcarchive/Products/usr/local/include \
-output build/YourFramework.xcframework
```

If you want to create an XCFramework from a Framework instead replace the above code with something like this

```
xcodebuild -create-xcframework \
-framework build/device.xcarchive/Products/Library/Frameworks/YourFramework.framework \
-framework build/simulator.xcarchive/Products/Library/Frameworks/YourFramework.framework \
-output build/YourFramework.xcframework
```

Then you can just run the shell script in it's directory
`sh build.sh`
You should have an XCFramework inside of the build folder indicated in `-output`

### Starting a Support Session

The application starts a support session, normally in response to the user clicking on a **Help** or **Request Support** button, by making a call to the AssistSDK.startSupport class method:

- The argument is a configuration object. Please see <doc:Configuration>

Swift
```swift
import LASDKiOS

class WelcomeController {

    func startLiveAssist(_ config: Configuration) async {
        let sdk = try await AssistSDK.startSupport(config)
    }
}
```

Objective-C
```objective-c
@import LASDKiOS;

@interface WelcomeController ()
@end

@implementation WelcomeController

    -(void) startLiveAssist:(Configuration)config {
        [AssistSDK startSupport:config completionHandler:^(AssistSDK *sdk, NSError * error) {

        }];
    }
@end
```
