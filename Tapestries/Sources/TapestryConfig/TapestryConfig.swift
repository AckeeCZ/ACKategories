import PackageDescription

let config = TapestryConfig(release: Release(actions: [.pre(.docsUpdate),
                                                       .pre(.dependenciesCompatibility([.cocoapods, .carthage, .spm(.iOS)]))],
                                             add: ["README.md",
                                                   "ACKategories.podspec",
                                                   "CHANGELOG.md"],
                                             commitMessage: "Version \(Argument.version)",
                                             push: true))
