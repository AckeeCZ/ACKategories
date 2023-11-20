import Foundation

public struct BetterURL: RawRepresentable, Codable, Hashable {
    public let url: URL
    public let rawValue: String

    public init(url: URL) {
        self.url = url
        self.rawValue = url.absoluteString
    }

    public init?(rawValue: String) {
        self.rawValue = rawValue

        var replacedURLString: String {
            rawValue
                .replacingOccurrences(of: " ", with: "%20")
                .replacingOccurrences(of: "{", with: "%7B")
                .replacingOccurrences(of: "}", with: "%7D")
        }

        if let url = URL(string: rawValue) {
            self.url = url
        } else if let url = URL(string: replacedURLString) {
            self.url = url
        } else {
            return nil
        }
    }
}
