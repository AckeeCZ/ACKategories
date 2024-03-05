import Foundation
import Networking

@available(tvOS 13.0, iOS 13.0, watchOS 6.0, macOS 10.15, *)
public final class Network_Mock: Network {
    public var requestBody: (URLRequest) async throws -> HTTPResponse = { _ in .test() }
    public var uploadBody: (URLRequest, Data) async throws -> HTTPResponse = { _, _ in .test() }

    public init() {
        
    }

    public func request(_ request: URLRequest) async throws -> HTTPResponse {
        try await requestBody(request)
    }

    public func upload(
        _ request: URLRequest,
        from: Data
    ) async throws -> HTTPResponse {
        try await uploadBody(request, from)
    }
}
