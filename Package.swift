// swift-tools-version: 5.7
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "ScrollViewStyle",
    platforms: [
        .iOS(.v14)
    ],
    products: [
        .library(
            name: "ScrollViewStyle",
            targets: ["ScrollViewStyle"]),
    ],
    dependencies: [
        .package(url: "https://github.com/siteline/SwiftUI-Introspect", "0.1.4"..<"1.0.0"),
        .package(url: "https://github.com/TimmysApp/STools", "1.0.74"..<"1.1.0")
    ],
    targets: [
        .target(
            name: "ScrollViewStyle",
            dependencies: [
                .product(name: "Introspect", package: "SwiftUI-Introspect"),
                .product(name: "STools", package: "STools")
            ]),
        .testTarget(
            name: "ScrollViewStyleTests",
            dependencies: ["ScrollViewStyle"]),
    ]
)
