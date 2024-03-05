import Foundation

/// Protocol wrapping objects that perform network requests
@available(tvOS 13.0, iOS 13.0, watchOS 6.0, macOS 10.15, *)
public protocol APIServicing {
    /// Send given `URLRequest`
    /// - Parameter request: Request to be sent
    /// - Returns: HTTPResponse to given request
    func request(_ request: URLRequest) async throws -> HTTPResponse
    
    /// Construct and send request using given parameters
    /// - Parameters:
    ///   - address: Request address
    ///   - method: Request method
    ///   - query: Query parameters
    ///   - headers: Custom headers
    ///   - body: Request body
    /// - Returns: Received HTTP response
    func request(
        _ address: RequestAddress,
        method: HTTPMethod,
        query: [String: String]?,
        headers: [String: String]?,
        body: RequestBody?
    ) async throws -> HTTPResponse
    
    func upload(
        _ address: RequestAddress,
        method: HTTPMethod,
        query: [String: String]?,
        headers: [String: String]?,
        multipart multipartBuilder: @escaping (inout MultipartFormData) async -> ()
    ) async throws -> HTTPResponse
}

/// Protocol wrapping interceptors that can modify requests before they are sent
@available(tvOS 13.0, iOS 13.0, watchOS 6.0, macOS 10.15, *)
public protocol RequestInterceptor {
    /// Intercept request sent by service
    /// - Parameters:
    ///   - service: Service that wants to send given request
    ///   - request: Request that should be sent and can be modified
    func intercept(
        service: APIServicing,
        request: inout URLRequest
    ) async throws
}

/// Protocol wrapping interceptors that can modify responses before they are returned from API service
@available(tvOS 13.0, iOS 13.0, watchOS 6.0, macOS 10.15, *)
public protocol ResponseInterceptor {
    /// Intercept response that was returned to service
    /// - Parameters:
    ///   - service: Service that received given response
    ///   - response: Response that was received and can be modified
    func intercept(
        service: APIServicing,
        response: inout HTTPResponse
    ) async throws
}
