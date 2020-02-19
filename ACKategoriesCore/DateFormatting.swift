import Foundation

/// Date formatters cached for future use
private var dateFormattersCache = [String: DateFormatter]()

extension DateFormatter {

    /// Returns existing DateFormatter from cache or creates the new one
    @available(macOS 10.10, *)
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
