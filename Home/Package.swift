//
//  Package.swift
//  Home
//
//  Created by Achmad Rijalu on 29/05/26.
//

// swift-tools-version: 6.1
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "Home",
    platforms: [
        .iOS(.v15),
    ],
    products: [
        .library(
            name: "Home",
            targets: ["Home"]),
    ],
    dependencies: [
        .package(url: "https://github.com/Alamofire/Alamofire.git", .upToNextMajor(from: "5.10.2")),
        .package(url: "https://github.com/realm/realm-swift", exact: "10.54.5"),
        .package(path: "../Core"),

    ],
    targets: [
        .target(
            name: "Home",
            dependencies: [
                .product(name: "Alamofire", package: "Alamofire"),
                .product(name: "RealmSwift", package: "realm-swift"),
                "Core"
            ]
            
        ),
    ]
)
