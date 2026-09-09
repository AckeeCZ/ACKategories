import Foundation

/// Protocol wrapping raw network requests, basically URLSession
public protocol Network {
    /// Send given request
    /// - Parameter request: Request to be sent
    /// - Returns: Received response
    func request(_ request: URLRequest) async throws -> HTTPResponse
}

extension URLSession: Network {
    public func request(_ request: URLRequest) async throws -> HTTPResponse {
        let (data, response) = try await data(for: request)
        
        return .init(
            request: request,
            response: response as? HTTPURLResponse,
            data: data
        )
    }
}
