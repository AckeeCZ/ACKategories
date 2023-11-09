import Foundation

extension Bundle {
    /// Get receipt data
    public var receiptData: Data? { return appStoreReceiptURL.flatMap { try? Data(contentsOf: $0) } }

    /// Get `CFBundleShortVersionString`
    public var version: String? { return infoDictionary?["CFBundleShortVersionString"] as? String }

    /// Get `CFBundleVersion`
    public var buildNumber: Int? { return (infoDictionary?["CFBundleVersion"] as? String).flatMap { Int($0) } }
}
