// swift-tools-version: 6.0
import PackageDescription

let package = Package(
    name: "PrintingKit",
    platforms: [
        .iOS(.v13),
        .macOS(.v11),
        .tvOS(.v13),
        .watchOS(.v7),
        .visionOS(.v1)
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
