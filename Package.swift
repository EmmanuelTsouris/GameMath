// swift-tools-version: 6.2
import PackageDescription

let package = Package(
    name: "GameMath",
    platforms: [
        .iOS(.v26),
        .macOS(.v26),
        .tvOS(.v26),
        .visionOS(.v26)
    ],
    products: [
        .library(
            name: "GameMath",
            targets: ["GameMath"]
        )
    ],
    dependencies: [
        // Add dependencies here
    ],
    targets: [
        .target(
            name: "GameMath",
            dependencies: [],
            swiftSettings: [
                .enableUpcomingFeature("StrictConcurrency")
            ]
        ),
        .testTarget(
            name: "GameMathTests",
            dependencies: ["GameMath"]
        )
    ]
)
