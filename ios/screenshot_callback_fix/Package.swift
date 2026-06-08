// swift-tools-version: 5.9
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "screenshot_callback_fix",
    platforms: [
        .iOS("13.0")
    ],
    products: [
        .library(name: "screenshot-callback-fix", targets: ["screenshot_callback_fix"])
    ],
    dependencies: [
        .package(name: "FlutterFramework", path: "../FlutterFramework")
    ],
    targets: [
        .target(
            name: "screenshot_callback_fix",
            dependencies: [
                .product(name: "FlutterFramework", package: "FlutterFramework")
            ]
        )
    ]
)
