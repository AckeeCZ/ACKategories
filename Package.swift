// swift-tools-version:5.9
import PackageDescription

let package = Package(
    name: "ACKategories",
    platforms: [
        .iOS(.v15),
        .macOS(.v12),
        .watchOS(.v9),
        .tvOS(.v15),
    ],
    products: [
        .library(name: "ACKategories", targets: ["ACKategories"]),
        .library(name: "ACKategoriesTesting", targets: ["ACKategoriesTesting"]),
        .library(name: "Networking", targets: ["Networking"]),
        .library(name: "PushNotifications", targets: ["PushNotifications"]),
    ],
    targets: [
        .target(
            name: "ACKategories",
            resources: [
                .copy("PrivacyInfo.xcprivacy"),
            ]
        ),
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
        .target(name: "PushNotifications"),
    ]
)
