// swift-tools-version: 5.6

import PackageDescription

let package = Package(
    name: "BBSwift",
    platforms: [
        .macOS(.v10_15), 
        .iOS(.v13)],
    products: [
        .library(
            name: "BBSwift",
            targets: ["BBSwift", "BBSwiftFramework"]),
    ],
    targets: [
        .target(
            name: "BBSwift",
            dependencies: ["BBSwiftFramework"],
            path: "Swift/Sources/BBSwift",
            linkerSettings: [ .linkedFramework("SystemConfiguration") ]
        ),
        .binaryTarget(
            name: "BBSwiftFramework",
            url: "https://github.com/porco-rosso-j/bb-swift/releases/download/v0.46.1/BBSwift.xcframework.zip",
            checksum: "cf9a38bbf0bee61a88a15d4aca412cb336c2eac79b49943e2f08b010146539c2"
        ),
        .testTarget(
            name: "SwiftBridgeTest",
            dependencies: ["BBSwift"],
            path: "Swift/Tests/SwiftBridgeTest"
        ),
    ]
)
