// swift-tools-version:5.0
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "ESMigration",
    platforms: [.iOS(.v10), .macOS(.v10_10), .tvOS(.v10), .watchOS(.v3)],
    products: [
        .library(name: "ESMigration", targets: ["ESMigration"]),
    ],
    dependencies: [],
    targets: [
        .target(name: "ESMigration", dependencies: []),
        .testTarget(name: "ESMigrationTests", dependencies: ["ESMigration"]),
    ]
)
