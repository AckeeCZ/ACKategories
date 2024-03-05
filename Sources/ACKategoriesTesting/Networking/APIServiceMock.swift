import Foundation
import Networking

@available(tvOS 13.0, iOS 13.0, watchOS 6.0, macOS 10.15, *)
public final class APIService_Mock: APIServicing {
    public struct UploadParams {
        let address: RequestAddress
        let method: HTTPMethod
        let query: [String: String]?
        let headers: [String: String]?
        let multipart: (inout MultipartFormData) async -> ()
    }

    public init() {
        
    }

    public var requestBody: (URLRequest) async throws -> HTTPResponse = {
        .test(request: $0)
    }

    public var uploadBody: (UploadParams) async throws -> HTTPResponse = { _ in
        .test()
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
        let url = switch address {
        case .url(let url): url
        case .path(let path): URL.ackeeCZ.appendingPathComponent(path)
        @unknown default:
            fatalError("Unknown case not supposed to be called")
        }
        
        return try await request(.init(
            url: url,
            method: method,
            query: query,
            headers: headers,
            body: body
        ))
    }

    public func upload(
        _ address: RequestAddress,
        method: HTTPMethod,
        query: [String: String]?,
        headers: [String: String]?,
        multipart multipartBuilder: @escaping (inout MultipartFormData) async -> ()
    ) async throws -> HTTPResponse {
        try await uploadBody(.init(
            address: address,
            method: method,
            query: query,
            headers: headers,
            multipart: multipartBuilder
        ))
    }
}
