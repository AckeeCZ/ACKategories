import PackageDescription

let config = TapestryConfig(release: Release(actions: [.pre(.docsUpdate),
                                                       .pre(.dependenciesCompatibility([.cocoapods, .carthage, .spm(.all)]))],
                                             add: ["README.md", "TapestryDemo.podspec"],
                                             commitMessage: "Version \(Argument.version)",
                                             push: false))