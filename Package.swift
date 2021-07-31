// swift-tools-version:5.3

import PackageDescription

let package = Package(
    name: "AnimatedImage",
    platforms: [.iOS(.v13)],
    products: [
        .library(
            name: "AnimatedImage",
            targets: ["AnimatedImage"]),
    ],
    targets: [
        .target(
            name: "AnimatedImage",
            dependencies: []),
    ]
)
