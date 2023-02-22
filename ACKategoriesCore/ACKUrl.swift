//
//  ACKUrl.swift
//  ACKategories
//
//  Created by Alexandr Grigoryev on 21.02.2023.
//

import Foundation

public struct ACKUrl: RawRepresentable {
   public let url: URL

   public init?(rawValue: String) {
        guard let urlString = rawValue.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed),
              let url = URL(string: urlString) else {
            return nil
        }
        self.url = url
    }

  public var rawValue: String {
        return url.absoluteString
    }
}

