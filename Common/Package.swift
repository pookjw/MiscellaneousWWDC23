// swift-tools-version: 5.9
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "Common",
    platforms: [.iOS(.v17)],
    products: [
        .library(
            name: "Common",
            targets: ["Common"]
        )
    ],
    targets: [
        .target(
            name: "Common"
        )
    ]
)
