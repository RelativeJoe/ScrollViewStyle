// swift-tools-version: 5.7
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "ScrollViewStyle",
    platforms: [
        .iOS(.v14)
    ],
    products: [
        // Products define the executables and libraries a package produces, and make them visible to other packages.
        .library(
            name: "ScrollViewStyle",
            targets: ["ScrollViewStyle"]),
    ],
    dependencies: [
        .package(url: "https://github.com/siteline/SwiftUI-Introspect", "0.1.4"..<"1.0.0")
    ],
    targets: [
        // Targets are the basic building blocks of a package. A target can define a module or a test suite.
        // Targets can depend on other targets in this package, and on products in packages this package depends on.
        .target(
            name: "ScrollViewStyle",
            dependencies: [
                .product(name: "Introspect", package: "SwiftUI-Introspect")
            ]),
        .testTarget(
            name: "ScrollViewStyleTests",
            dependencies: ["ScrollViewStyle"]),
    ]
)
