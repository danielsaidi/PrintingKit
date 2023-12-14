// swift-tools-version: 5.8
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "PrintingKit",
    platforms: [
        .iOS(.v13),
        .macOS(.v11),
        .tvOS(.v13),
        .watchOS(.v7)
    ],
    products: [
        .library(
            name: "PrintingKit",
            targets: ["PrintingKit"]
        )
    ],
    targets: [
        .target(
            name: "PrintingKit"
        ),
        .testTarget(
            name: "PrintingKitTests",
            dependencies: ["PrintingKit"]
        )
    ]
)
