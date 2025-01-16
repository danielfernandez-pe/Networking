// swift-tools-version: 5.9
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "Networking",
    platforms: [.iOS(.v17)],
    products: [
        .library(
            name: "Networking",
            targets: ["Networking"]),
    ],
    dependencies: [
        .package(url: "git@github.com:danielfernandez-pe/Logger.git", from: "1.2.1")
    ],
    targets: [
        .target(
            name: "Networking",
            dependencies: [
                .product(name: "Lumberjack", package: "Logger"),
            ],
            path: "Sources"
        ),
        .testTarget(
            name: "NetworkingTests",
            dependencies: ["Networking"]),
    ]
)
