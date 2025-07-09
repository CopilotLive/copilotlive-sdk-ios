// swift-tools-version: 5.9
// The swift-tools-version declares the minimum version of Swift required to build this package.

// swift-tools-version:5.5
import PackageDescription

let package = Package(
    name: "CopilotSDK",
    defaultLocalization: "en", 
    platforms: [
        .iOS(.v14)  // Set the minimum iOS version you are targeting
    ],
    products: [
        .library(
            name: "CopilotSDK",
            targets: ["CopilotSDK"]
        )
    ],
    targets: [
        .binaryTarget(
            name: "CopilotSDK",
            path: "Sources/Frameworks/CopilotSDK.xcframework"  // Path to the .xcframework
        )
    ]
)

