import Foundation
import Networking

public extension HTTPResponse {
    static func test(
        request: URLRequest = .test(),
        response: HTTPURLResponse? = nil,
        data: Data? = nil
    ) -> HTTPResponse {
        .init(
            request: request,
            response: response,
            data: data
        )
    }
}
