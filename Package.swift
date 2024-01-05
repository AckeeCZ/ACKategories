// swift-tools-version:5.9
import PackageDescription

let package = Package(
    name: "ACKategories",
    platforms: [
        .iOS(.v12),
        .macOS(.v10_13),
        .watchOS(.v5),
        .tvOS(.v12),
    ],
    products: [
        .library(name: "ACKategories", targets: ["ACKategories"]),
        .library(name: "ACKategoriesTesting", targets: ["ACKategoriesTesting"]),
        .library(name: "Networking", targets: ["Networking"]),
    ],
    targets: [
        .target(name: "ACKategories"),
        .testTarget(
            name: "ACKategoriesTests",
            dependencies: [
                "ACKategories",
                "ACKategoriesTesting",
            ]
        ),
        .target(
            name: "ACKategoriesTesting",
            dependencies: [
                "ACKategories",
                "Networking",
            ]
        ),
        .target(name: "Networking"),
        .testTarget(
            name: "NetworkingTests",
            dependencies: [
                "ACKategoriesTesting",
                "Networking",
            ]
        ),
            dependencies: [
            ]
        ),
    ]
)
