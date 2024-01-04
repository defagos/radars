// swift-tools-version: 5.9
import PackageDescription

let package = Package(
    name: "Pillarbox",
    platforms: [
        .iOS(.v17),
        .tvOS(.v17)
    ],
    products: [
        .library(
            name: "Core",
            targets: ["Core"]
        ),
        .library(
            name: "Player",
            targets: ["Player"]
        )
    ],
    targets: [
        .target(
            name: "Core"
        ),
        .testTarget(
            name: "CoreTests",
            dependencies: ["Core"]
        ),
        .target(
            name: "Player",
            dependencies: ["Core"]
        ),
        .testTarget(
            name: "PlayerTests",
            dependencies: ["Player"]
        )
    ]
)
