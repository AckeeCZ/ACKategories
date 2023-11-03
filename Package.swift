// swift-tools-version:5.9
import PackageDescription

let package = Package(
    name: "ACKategories",
    platforms: [
        .iOS(.v12),
        .macOS(.v10_13)
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
    ]
)
