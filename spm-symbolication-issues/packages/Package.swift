// swift-tools-version:5.3

import PackageDescription

let package = Package(
    name: "package",
    products: [
        .library(
            name: "ObjCWithoutResources",
            targets: ["ObjCWithoutResources"]
        ),
        .library(
            name: "ObjCWithResources",
            targets: ["ObjCWithResources"]
        ),
        .library(
            name: "SwiftWithoutResources",
            targets: ["SwiftWithoutResources"]
        ),
        .library(
            name: "SwiftWithResources",
            targets: ["SwiftWithResources"]
        )
    ],
    targets: [
        .target(
            name: "ObjCWithoutResources"
        ),
        .target(
            name: "ObjCWithResources",
            resources: [
                .process("Resources")
            ]
        ),
        .target(
            name: "SwiftWithoutResources"
        ),
        .target(
            name: "SwiftWithResources",
            resources: [
                .process("Resources")
            ]
        )
    ]
)
