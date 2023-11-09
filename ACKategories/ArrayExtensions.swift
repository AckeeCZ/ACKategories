import Foundation

extension Array where Element: Equatable {
    /// Remove given object
    public mutating func remove(object: Element) {
        if let index = firstIndex(of: object) {
            remove(at: index)
        }
    }
}
