import ACKategories

public final class VersionUpdateFetcher_Mock: MinBuildNumberFetcher {
    public var minBuildNumber = 0

    public init(minBuildNumber: Int = 0) {
        self.minBuildNumber = minBuildNumber
    }
}
