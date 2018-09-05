import Foundation

extension Array where Element: Equatable {
    /// Remove given object
    public mutating func remove(object: Element) {
        if let index = index(of: object) {
            remove(at: index)
        }
    }
}
