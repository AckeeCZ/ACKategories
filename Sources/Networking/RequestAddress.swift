import Foundation

/// Represents request address that could be relative to service's base URL
///
/// If initialized by string literal/interpolation, respective case is created,
/// if Foundation.URL can be created and scheme is not empty, it creates `.url` otherwise `.path`
public enum RequestAddress: Hashable {
    case url(URL)
    case path(String)
}

extension RequestAddress: ExpressibleByStringInterpolation {
    public init(stringLiteral value: String) {
        if let url = URL(string: value),
           let scheme = url.scheme,
           !scheme.isEmpty {
            self = .url(url)
        } else {
            self = .path(value)
        }
    }
}

public extension RequestAddress {
    func url(_ baseURL: @autoclosure () -> URL) -> URL {
        switch self {
        case .url(let url): url
        case .path(let path): baseURL().appendingPathComponent(path)
        }
    }
}
