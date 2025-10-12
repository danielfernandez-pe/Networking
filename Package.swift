// swift-tools-version: 6.0
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "Networking",
    platforms: [.iOS(.v18)],
    products: [
        .library(
            name: "RESTClient",
            targets: ["RESTClient"]
        ),
        .library(
            name: "FirebaseClient",
            targets: ["FirebaseClient"]
        )
    ],
    dependencies: [
        .package(url: "https://github.com/firebase/firebase-ios-sdk.git", from: "12.4.0"),
    ],
    targets: [
        .target(
            name: "RESTClient",
            dependencies: [],
            path: "Sources/REST",
            swiftSettings: [
                .enableExperimentalFeature("StrictConcurrency")
            ]
        ),
        .target(
            name: "FirebaseClient",
            dependencies: [
                .product(name: "FirebaseFirestore", package: "firebase-ios-sdk")
            ],
            path: "Sources/Firebase",
            swiftSettings: [
                .enableExperimentalFeature("StrictConcurrency")
            ]
        )
    ]
)
