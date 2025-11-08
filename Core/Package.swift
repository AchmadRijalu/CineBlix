// swift-tools-version: 6.1
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "Core",
    platforms: [
        .iOS(.v15),
    ],
    products: [
        .library(
            name: "Core",
            targets: ["Core"]),
    ],
    dependencies: [
        .package(url: "https://github.com/realm/realm-swift", exact: "10.54.5")
    ],
    targets: [
        .target(
            name: "Core",
            dependencies: [
                .product(name: "RealmSwift", package: "realm-swift")
            ]
        ),

    ]
)
