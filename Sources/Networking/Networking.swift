import Foundation

/// Protocol wrapping raw network requests, basically URLSession
@available(tvOS 13.0, iOS 13.0, watchOS 6.0, macOS 10.15, *)
public protocol Networking {
    /// Send given request
    /// - Parameter request: Request to be sent
    /// - Returns: Received response
    func request(_ request: URLRequest) async throws -> HTTPResponse
}

@available(tvOS 13.0, iOS 13.0, watchOS 6.0, macOS 12.0, *)
extension URLSession: Networking {
    public func request(_ request: URLRequest) async throws -> HTTPResponse {
        let (data, response) = try await data(for: request)
        
        return .init(
            request: request,
            response: response as? HTTPURLResponse,
            data: data
        )
    }
}
