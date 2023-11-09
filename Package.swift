// swift-tools-version:5.9
import PackageDescription

let package = Package(
    name: "ACKategories",
    platforms: [
        .iOS(.v12),
        .macOS(.v10_13)
    ],
    products: [
        .library(name: "ACKategories", targets: ["ACKategories"]),
    ],
    targets: [
        .target(name: "ACKategories"),
        .testTarget(
            name: "ACKategoriesTests",
            dependencies: ["ACKategories"],
            swiftSettings: [
                .define("SPM_TESTS"),
            ]
        ),
    ]
)
