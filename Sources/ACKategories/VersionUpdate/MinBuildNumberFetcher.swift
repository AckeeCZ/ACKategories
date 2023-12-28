import Foundation

@available(tvOS 13.0, iOS 13.0, watchOS 6.0, macOS 10.15, *)
public protocol MinBuildNumberFetcher {
    var minBuildNumber: Int { get async throws }
}
