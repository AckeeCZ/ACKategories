//
//  ACKUrl.swift
//  ACKategories
//
//  Created by Alexandr Grigoryev on 21.02.2023.
//

import Foundation

public struct BetterURL: RawRepresentable, Codable, Hashable {
    public let url: URL
    public let rawValue: String

    public init?(rawValue: String) {
        if let url = URL(string: rawValue) {
            self.url = url
        } else {
            let urlString = rawValue
                .replacingOccurrences(of: " ", with: "%20")
                .replacingOccurrences(of: "{", with: "%7B")
                .replacingOccurrences(of: "}", with: "%7D")

            guard let replacedUrl = URL(string: urlString) else { return nil }
            self.url = replacedUrl
        }
        self.rawValue = rawValue
    }
}

