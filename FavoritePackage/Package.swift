//
//  Package.swift
//  Favorite
//
//  Created by Achmad Rijalu on 29/05/26.
//

// swift-tools-version: 6.1

import PackageDescription

let package = Package(
    name: "Favorite",
    platforms: [
        .iOS(.v15),
    ],
    products: [
        .library(
            name: "Favorite",
            targets: ["Favorite"]
        ),
    ],
    dependencies: [
        .package(url: "https://github.com/realm/realm-swift", exact: "20.0.4"),
        .package(path: "../Core"),
    ],
    targets: [
        .target(
            name: "Favorite",
            dependencies: [
                .product(name: "RealmSwift", package: "realm-swift"),
                "Core",
            ]
        ),
    ]
)
