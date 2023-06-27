// swift-tools-version: 5.7
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "swift-lasdk-ios",
    platforms: [.iOS(.v11)],
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
                "WebRTC"
            ]
        ),
        .binaryTarget(name: "LASDKiOS", url: "https://swift-sdk.s3.us-east-2.amazonaws.com/lasdk/LASDKiOS-2.0.0.xcframework.zip", checksum: "469809d6d68b7b854529ec09e24b46b0d3d2405b28d66654ac155a7d6594efe8"),
        .binaryTarget(name: "FCSDKiOS", url: "https://swift-sdk.s3.us-east-2.amazonaws.com/client_sdk/FCSDKiOS-4.2.4.xcframework.zip", checksum: "1b32b01e266f4bd98aa6849567b4341a41905a40a958fd6c2061eebb8e8df386"),
        .binaryTarget(name: "WebRTC", url: "https://swift-sdk.s3.us-east-2.amazonaws.com/real_time/WebRTC-m110.xcframework.zip", checksum: "2750cf1087b2441d67208ca2b0905578b4ad1797a68d2d2758d0f075500f0011")
    ]
)
