// swift-tools-version: 6.1
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "CommonKit",
    defaultLocalization: "en",
    products: [

        .library(
            name: "CommonKit",
            targets: ["CommonKit"]),
    ],
    targets: [
        .target(
            name: "CommonKit",
            path: "Sources/CommonKit",
            resources: [
                .process("Resources/Assets.xcassets"),
                .process("Resources/Localization")
            ]
        ),

    ]
)
