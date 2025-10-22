// swift-tools-version: 5.9
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "RickAndMortyKit",
    platforms: [
        .iOS(.v15)
    ],
    products: [
        .library(
            name: "RickAndMortyKit",
            targets: ["RickAndMortyKit"]
        )
    ],
    targets: [
        .target(
            name: "RickAndMortyKit",
            dependencies: [],
            path: "Sources"
        ),
        .testTarget(
            name: "RickAndMortyKitTests",
            dependencies: ["RickAndMortyKit"],
            path: "Tests"
        )
    ]
)
