//
//  DateFormatting.swift
//  Skeleton
//
//  Created by Jan Misar on 02.08.18.
//

import Foundation

/// Date formatters cached for future use
fileprivate var dateFormattersCache = [String: DateFormatter]()

extension DateFormatter {
    
    /// Returns existing DateFormatter from cache or creates the new one
    public static func cached(for template: String) -> DateFormatter {
        if let cachedFormatter = dateFormattersCache[template] {
            return cachedFormatter
        } else {
            let dateFormatter = DateFormatter()
            dateFormatter.setLocalizedDateFormatFromTemplate(template)
            dateFormattersCache[template] = dateFormatter
            return dateFormatter
        }
    }
}
