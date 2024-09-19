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
            url: "https://github.com/porco-rosso-j/bb-swift/releases/download/v0.46.1-2/BBSwift.xcframework.zip",
            checksum: "f732107589bbf30799f5061c3c63140db40e96150c76fedbb13bcb81ce35d686"
        ),
        .testTarget(
            name: "SwiftBridgeTest",
            dependencies: ["BBSwift"],
            path: "Swift/Tests/SwiftBridgeTest"
        ),
    ]
)
