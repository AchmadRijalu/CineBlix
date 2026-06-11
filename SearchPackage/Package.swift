//
//  Package.swift
//  Search
//
//  Created by Achmad Rijalu on 29/05/26.
//

// swift-tools-version: 6.1
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "Search",
    platforms: [
        .iOS(.v15),
    ],
    products: [
        .library(
            name: "Search",
            targets: ["Search"]
        ),
    ],
    dependencies: [
        .package(url: "https://github.com/Alamofire/Alamofire.git", .upToNextMajor(from: "5.10.2")),
        .package(path: "../Core"),
    ],
    targets: [
        .target(
            name: "Search",
            dependencies: [
                .product(name: "Alamofire", package: "Alamofire"),
                "Core",
            ]
        ),
    ]
)
