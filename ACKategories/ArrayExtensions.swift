import Foundation

/// Safe subscript for collections
public protocol SafeRandomAccessCollection: RandomAccessCollection {
    subscript(safe index: Int) -> Iterator.Element? { get }
}

extension Array: SafeRandomAccessCollection {
    /// Return object at index if inside bounds, `nil` otherwise
    public subscript(safe index: Int) -> Iterator.Element? {
        return indices ~= index ? self[index] : nil
    }
}

extension Array where Element: Equatable {
    /// Remove given object
    public mutating func remove(object: Element) {
        if let index = index(of: object) {
            remove(at: index)
        }
    }
}
