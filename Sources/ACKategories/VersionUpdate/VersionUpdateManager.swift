import Foundation

@available(tvOS 13.0, iOS 13.0, watchOS 6.0, macOS 10.15, *)
public protocol VersionUpdateManaging {
    var updateRequired: Bool { get async }
}

@available(tvOS 13.0, iOS 13.0, watchOS 6.0, macOS 10.15, *)
public final class VersionUpdateManager: VersionUpdateManaging {
    public var updateRequired: Bool {
        get async {
            guard let min = try? await fetcher.minBuildNumber else { return false }
            return min > buildNumberProvider()
        }
    }
    
    private let buildNumberProvider: () -> Int
    private let fetcher: MinBuildNumberFetcher
    
    public init(
        buildNumberProvider: @escaping @autoclosure () -> Int = Bundle.main.infoDictionary
            .flatMap { $0["CFBundleVersion"] as? String }
            .flatMap(Int.init) ?? Int.max,
        fetcher: MinBuildNumberFetcher
    ) {
        self.buildNumberProvider = buildNumberProvider
        self.fetcher = fetcher
    }
}
