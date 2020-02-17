// swift-tools-version:5.0
import PackageDescription

let package = Package(
    name: "ACKategories",
    platforms: [
        .iOS("8.3"),
        .macOS("10.9")
    ],
    products: [
        .library(name: "ACKategories", targets: ["ACKategories-iOS"]),
        .library(name: "ACKategoriesCore", targets: ["ACKategoriesCore"]),
    ],
    targets: [
        .target(name: "ACKategories-iOS", dependencies: ["ACKategoriesCore"], path: "ACKategories-iOS"),
        .testTarget(name: "ACKategories-iOSTests", dependencies: ["ACKategories-iOS"], path: "ACKategories-iOSTests"),
        .target(name: "ACKategoriesCore", path: "ACKategoriesCore"),
        .testTarget(name: "ACKategoriesCoreTests", dependencies: ["ACKategoriesCore"], path: "ACKategoriesCoreTests"),
    ],
    swiftLanguageVersions: [
        .v5
    ]
)
