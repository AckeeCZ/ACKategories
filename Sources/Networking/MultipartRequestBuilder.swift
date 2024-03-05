import Foundation

@available(macOS 10.15, iOS 13.0, tvOS 13.0, watchOS 6.0, *)
struct MultipartRequestBodyBuilder {
    func buildRequestBody(_ multipart: MultipartFormData) async -> (boundary: String, body: Data) {
        let boundary = "cz.ackee.ACKategories.Networking.boundary." + UUID().uuidString
        let partsData = multipart.parts.map(multipartData)

        let boundaryData = Data(("--" + boundary).utf8)
        var data = boundaryData

        partsData.forEach { partData in
            data.append(.crlf)
            data.append(partData)
            data.append(boundaryData)
        }

        data.append(.crlf)

        return (boundary, data)
    }

    private func multipartData(_ part: MultipartFormData.Part) -> Data {
        let disposition = [
            "Content-Disposition: form-data",
            "name=\"" + part.name + "\"",
            part.fileName.map { "filename=\"" + $0 + "\"" },
        ]
            .compactMap { $0 }
            .joined(separator: "; ")

        let metadata = [
            disposition,
            part.contentType.map { "Content-Type: " + $0 },
            "", "",
        ]
            .compactMap { $0 }
            .joined(separator: .crlf)

        var resultData = Data(metadata.utf8)
        resultData.append(part.data)
        resultData.append(.crlf)
        return resultData
    }
}

private extension Data {
    static let crlf = Data(String.crlf.utf8)
}

private extension String {
    static let crlf = "\r\n"
}
