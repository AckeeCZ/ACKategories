// swift-tools-version:5.0
import PackageDescription

let package = Package(
    name: "ACKategories",
    platforms: [
        .iOS("8.3"),
    ],
    products: [
        .library(name: "ACKategories", targets: ["ACKategories"]),
    ],
    targets: [
        .target(name: "ACKategories", path: "ACKategories"),
    ],
    swiftLanguageVersions: [
        .v5
    ]
)
