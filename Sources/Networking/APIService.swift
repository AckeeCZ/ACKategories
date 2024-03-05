import Foundation

@available(tvOS 13.0, iOS 13.0, watchOS 6.0, macOS 10.15, *)
public final class APIService: APIServicing {
    /// Error thrown when response status code is unexpected
    public struct UnexpectedStatusCodeError: Error {
        /// Received response with unexpected status code
        public let response: HTTPResponse
        
        /// - Parameter response: Received response with unexpected status code
        public init(response: HTTPResponse) {
            self.response = response
        }
    }
    
    private let baseURLFactory: () -> URL
    private let network: Network
    private let requestInterceptors: [RequestInterceptor]
    private let responseInterceptors: [ResponseInterceptor]
    private lazy var multipartBodyBuilder = MultipartRequestBodyBuilder()

    /// Create new `APIService`
    /// - Parameters:
    ///   - baseURL: Base URL for requests that use path instead of full URL/request
    ///   - network: Network object performing API calls, `URLSession` basically
    ///   - requestInterceptors: List of request interceptors, useful for logging or header injections
    ///   - responseInterceptors: List of response interceptors, useful for logging or token refresh
    public init(
        baseURL: @autoclosure @escaping () -> URL,
        network: Network,
        requestInterceptors: [RequestInterceptor] = [],
        responseInterceptors: [ResponseInterceptor] = []
    ) {
        self.baseURLFactory = baseURL
        self.network = network
        self.requestInterceptors = requestInterceptors
        self.responseInterceptors = responseInterceptors
    }
    
    public func request(_ originalRequest: URLRequest) async throws -> HTTPResponse {
        var request = originalRequest
        
        for interceptor in requestInterceptors {
            try await interceptor.intercept(
                service: self,
                request: &request
            )
        }
        
        var response = try await network.request(request)
        
        for interceptor in responseInterceptors {
            try await interceptor.intercept(
                service: self,
                response: &response
            )
        }
        
        guard response.isAccepted() else {
            throw UnexpectedStatusCodeError(response: response)
        }
        
        return response
    }
    
    public func request(
        _ address: RequestAddress,
        method: HTTPMethod = .get,
        query: [String: String]? = nil,
        headers: [String: String]? = nil,
        body: RequestBody? = nil
    ) async throws -> HTTPResponse {
        return try await self.request(.init(
            url: address.url(baseURLFactory()),
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
        let multipart = await Task {
            var multipart = MultipartFormData()
            await multipartBuilder(&multipart)
            return multipart
        }.value
        let (boundary, body) = await multipartBodyBuilder.buildRequestBody(multipart)
        let headers = headers ?? [:]

        return try await network.upload(.init(
            url: address.url(baseURLFactory()),
            method: method,
            query: query,
            headers: headers.merging(["Content-Type": "multipart/form-data; boundary=" + boundary]) { $1 },
            body: nil
        ), from: body)
    }
}

public extension URLRequest {
    init(
        url: URL,
        method: HTTPMethod,
        query: [String: String]?,
        headers: [String: String]?,
        body: RequestBody?
    ) {
        let url: URL = {
            guard let query, !query.isEmpty else { return url }
       
            var urlComponents = URLComponents(url: url, resolvingAgainstBaseURL: true)
            var queryItems = urlComponents?.queryItems ?? []
            query.forEach { key, value in
                queryItems.append(.init(name: key, value: value))
            }
            urlComponents?.queryItems = queryItems
            
            return urlComponents?.url ?? url
        }()
        
        var request = URLRequest(url: url)
        request.httpMethod = method.rawValue
        request.httpBody = body?.data
        request.allHTTPHeaderFields = headers
        request.setValue(body?.contentType, forHTTPHeaderField: "Content-Type")
        self = request
    }
}
