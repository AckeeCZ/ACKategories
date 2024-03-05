import Foundation
import UIKit

public struct MultipartFormData {
    public struct CannotSerializeImageError: Error {
        let image: UIImage
        let requestedContentType: String
    }

    public struct CannotSerializeStringError: Error {
        let string: String
    }

    struct Part {
        let data: Data
        let name: String
        let fileName: String?
        let contentType: String?
    }

    private(set) var parts = [Part]()
}

public extension MultipartFormData {
    mutating func appendPart(
        _ data: Data,
        name: String,
        fileName: String? = nil,
        contentType: String? = nil
    ) {
        parts.append(.init(
            data: data,
            name: name,
            fileName: fileName,
            contentType: contentType
        ))
    }

    mutating func appendPart(
        jpeg: UIImage,
        name: String,
        compressionQuality: CGFloat = 1,
        fileName: String? = nil
    ) throws {
        let contentType = "image/jpeg"

        guard let data = jpeg.jpegData(compressionQuality: compressionQuality) else {
            throw CannotSerializeImageError(
                image: jpeg,
                requestedContentType: contentType
            )
        }

        appendPart(
            data,
            name: name,
            fileName: fileName,
            contentType: contentType
        )
    }

    mutating func appendPart(
        png: UIImage,
        name: String,
        compressionQuality: CGFloat = 1,
        fileName: String? = nil
    ) throws {
        let contentType = "image/png"

        guard let data = png.pngData() else {
            throw CannotSerializeImageError(
                image: png,
                requestedContentType: contentType
            )
        }

        appendPart(
            data,
            name: name,
            fileName: fileName,
            contentType: contentType
        )
    }

    mutating func appendPart(
        _ string: String,
        name: String,
        encoding: String.Encoding = .utf8,
        fileName: String? = nil,
        contentType: String? = nil
    ) throws {
        guard let data = string.data(using: encoding) else {
            throw CannotSerializeStringError(string: string)
        }

        parts.append(.init(
            data: data,
            name: name,
            fileName: fileName,
            contentType: contentType
        ))
    }
}
