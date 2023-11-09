import Foundation

extension Date {
    /// String from date formatted with given template
    ///
    /// Uses cached date formatter, so no need to worry about performance. See `DateFormatter.cached(for template:)`
    @available(macOS 10.10, *)
    public func toString(with template: String) -> String {
        return DateFormatter.cached(for: template).string(from: self)
    }
}
