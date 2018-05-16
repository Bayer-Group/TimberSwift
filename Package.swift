// swift-tools-version:4.1

import PackageDescription

let package = Package(
    name: "TimberSwift",
    products: [
        .library(
            name: "TimberSwift",
            targets:  ["TimberSwift"]
        )
    ],
    dependencies: [
    ],
    targets: [
        .target(
            name: "TimberSwift",
            dependencies: []
        ),
        .testTarget(
            name: "TimberSwiftTests",
            dependencies: ["TimberSwift"]
        )
    ]
)
