// swift-tools-version: 5.7
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "swift-lasdk-ios",
    platforms: [.iOS(.v13), .macOS(.v11)],
    products: [
        .library(
            name: "LASDKiOS",
            type: .static,
            targets: ["SwiftLASDKiOS"]),
    ],
    dependencies: [],
    targets: [
        .target(
            name: "SwiftLASDKiOS",
            dependencies: [
                "LASDKiOS",
                "FCSDKiOS",
                "CBARealTime"
            ]
        ),
        .binaryTarget(name: "LASDKiOS", url: "https://swift-sdk.s3.us-east-2.amazonaws.com/lasdk/", checksum: "c291e75b284f0ea6370bb83a8872bee5335cd577feb3c3c2ff8ac4e92c25ef49"),
        .binaryTarget(name: "FCSDKiOS", url: "https://swift-sdk.s3.us-east-2.amazonaws.com/client_sdk/FCSDKiOS-4.2.0.xcframework.zip", checksum: "80c8a3014f4033a32c435f538e01341e7511b7c5d9a6cc917a7d396bb29cf0a5"),
        .binaryTarget(name: "CBARealTime", url: "https://swift-sdk.s3.us-east-2.amazonaws.com/real_time/CBARealTime-m110-1.0.0.xcframework.zip", checksum: "a2f4cee24ce4389aa00feb86edd8dc8c67a43aedf1f8b4ceb5998c94f16a5e3d")
    ]
)
