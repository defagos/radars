// swift-tools-version: 5.9
import PackageDescription

let package = Package(
    name: "StandardPlayback",
    platforms: [
        .iOS(.v17),
        .tvOS(.v17)
    ],
    products: [
        .library(
            name: "StandardPlayback",
            targets: ["StandardPlayback"]
        ),
    ],
    dependencies: [
        .package(name: "alamofire", path: "../Alamofire"),
        .package(name: "pillarbox", path: "../Pillarbox")
    ],
    targets: [
        .target(
            name: "StandardPlayback",
            dependencies: [
                .product(
                    name: "Networking",
                    package: "alamofire",
                    moduleAliases: [
                        "Core": "AlamofireCore"
                    ]
                ),
                .product(
                    name: "Player",
                    package: "pillarbox",
                    moduleAliases: [
                        "Core": "PillarboxCore"
                    ]
                )
            ]
        ),
        .testTarget(
            name: "StandardPlaybackTests",
            dependencies: ["StandardPlayback"]
        )
    ]
)
