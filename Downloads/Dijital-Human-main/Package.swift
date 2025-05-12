// swift-tools-version:5.5
import PackageDescription

let package = Package(
    name: "Virtual Human",
    platforms: [
        .iOS(.v15),
        .macOS(.v12)
    ],
    products: [
        .library(
            name: "Virtual Human",
            targets: ["Virtual Human"]),
    ],
    dependencies: [],
    targets: [
        .target(
            name: "Virtual Human",
            dependencies: [],
            swiftSettings: [
                .define("DEBUG", .when(configuration: .debug))
            ]),
        .testTarget(
            name: "Virtual HumanTests",
            dependencies: ["Virtual Human"]),
    ]
) 