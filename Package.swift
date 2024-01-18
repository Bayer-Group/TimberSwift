// swift-tools-version:5.5

import PackageDescription

let package = Package(
    name: "TimberSwift",
    platforms: [
        .iOS(.v15),
        .macOS(.v12)
    ],
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
