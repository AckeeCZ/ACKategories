import Foundation
import Networking

public final class Network_Mock: Network {
    public var requestBody: (URLRequest) async throws -> HTTPResponse = { _ in .test() }

    public init() {
        
    }

    public func request(_ request: URLRequest) async throws -> HTTPResponse {
        try await requestBody(request)
    }
}
