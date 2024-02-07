import Foundation
import Networking

@available(tvOS 13.0, iOS 13.0, watchOS 6.0, macOS 10.15, *)
public final class APIService_Mock: APIServicing {
    public init() {
        
    }

    public var requestBody: (URLRequest) async throws -> HTTPResponse = {
        .init(request: $0, response: nil, data: nil)
    }

    public func request(_ request: URLRequest) async throws -> HTTPResponse {
        try await requestBody(request)
    }
    
    public func request(
        _ address: RequestAddress,
        method: HTTPMethod,
        query: [String: String]?,
        headers: [String: String]?,
        body: RequestBody?
    ) async throws -> HTTPResponse {
        let url: URL = {
            switch address {
            case .url(let url): return url
            case .path(let path):
                return .ackeeCZ.appendingPathComponent(path)
            @unknown default:
                fatalError("Unknown case not supposed to be called")
            }
        }()
        
        return try await request(.init(
            url: url,
            method: method,
            query: query,
            headers: headers,
            body: body
        ))
    }
}
