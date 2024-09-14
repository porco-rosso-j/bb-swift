// swift-tools-version: 5.6

import PackageDescription

let package = Package(
    name: "BBSwift",
    platforms: [
        .macOS(.v10_15), 
        .iOS(.v14)],
    products: [
        .library(
            name: "BBSwift",
            targets: ["BBSwift"]),
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
            url: "https://github.com/porco-rosso-j/react-native-bb.js/releases/download/v0.46.1/BBSwift.xcframework.zip",
            checksum: "e868c3f820d447ec9c8f50a306e4172eb026ed3b0c9639db1949cde8a43ed5c9"
        ),
        .testTarget(
            name: "SwiftBridgeTest",
            dependencies: ["BBSwift"],
            path: "Swift/Tests/SwiftBridgeTest"
        ),
    ]
)
