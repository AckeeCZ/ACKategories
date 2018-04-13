//
//  NSAttributedStringExtensions.swift
//  ACKategories
//
//  Created by Josef Dolezal on 04/02/2018.
//  Copyright © 2018 Josef Dolezal. All rights reserved.
//

import Foundation

public extension NSAttributedString {
    /// Append another attributed string
    public func byAppending(_ other: NSAttributedString) -> NSAttributedString {
        let result = NSMutableAttributedString()

        result.append(self)
        result.append(other)

        return result
    }

    /// Concat two attributed strings
    public static func +(_ lhs: NSAttributedString, _ rhs: NSAttributedString) -> NSAttributedString {
        return lhs.byAppending(rhs)
    }
}
