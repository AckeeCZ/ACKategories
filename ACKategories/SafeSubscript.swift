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
