@testable import Networking
import XCTest

@MainActor
final class MultipartRequestBodyBuilder_Tests: XCTestCase {
    func test_build() async throws {
        let builder = MultipartRequestBodyBuilder()
        let image = UIColor.red.image(of: .init(width: 30, height: 30))
        let imageData = try XCTUnwrap(image.jpegData(compressionQuality: 1))
        let multipart = MultipartFormData(parts: [
            .init(
                data: .init("string".utf8),
                name: "string",
                fileName: nil,
                contentType: nil
            ),
            .init(
                data: imageData,
                name: "image",
                fileName: "image.jpeg",
                contentType: "image/jpeg"
            )
        ])

        let (boundary, body) = await builder.buildRequestBody(multipart)

        let preImageBody = """
        --\(boundary)
        Content-Disposition: form-data; name="string"

        string
        --\(boundary)
        Content-Disposition: form-data; name="image"; filename="image.jpeg"
        Content-Type: image/jpeg
        \n
        """.replacingOccurrences(of: "\n", with: "\r\n")
        let postImageBody = """
        \n--\(boundary)\n
        """.replacingOccurrences(of: "\n", with: "\r\n")

        var expectedBody = Data(preImageBody.utf8)
        expectedBody.append(imageData)
        expectedBody.append(.init(postImageBody.utf8))

        XCTAssertEqual(expectedBody, body)
    }
}
