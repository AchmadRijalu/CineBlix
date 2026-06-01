//
//  Package.swift
//  DetailMovie
//
//  Created by Achmad Rijalu on 29/05/26.
//

// swift-tools-version: 6.1

import PackageDescription

let package = Package(
    name: "DetailMovie",
    platforms: [.iOS(.v15)],
    products: [
        .library(name: "DetailMovie", targets: ["DetailMovie"]),
    ],
    dependencies: [
        .package(url: "https://github.com/Alamofire/Alamofire.git", .upToNextMajor(from: "5.10.2")),
        .package(url: "https://github.com/realm/realm-swift", exact: "10.54.5"),
        .package(path: "../Core"),
        .package(path: "../FavoritePackage"),
    ],
    targets: [
        .target(
            name: "DetailMovie",
            dependencies: [
                .product(name: "Alamofire", package: "Alamofire"),
                .product(name: "RealmSwift", package: "realm-swift"),
                "Core",
                .product(name: "Favorite", package: "FavoritePackage"),
            ]
        ),
    ]
)
