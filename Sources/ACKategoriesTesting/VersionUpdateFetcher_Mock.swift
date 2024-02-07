import ACKategories

@available(tvOS 13.0, iOS 13.0, watchOS 6.0, macOS 10.15, *)
public final class VersionUpdateFetcher_Mock: MinBuildNumberFetcher {
    public var minBuildNumber = 0

    public init(minBuildNumber: Int = 0) {
        self.minBuildNumber = minBuildNumber
    }
}
