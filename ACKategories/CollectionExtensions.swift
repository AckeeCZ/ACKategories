import Foundation

extension Optional where Wrapped: Collection {
    /// Return `true` if `self` is empty or nil
    public var isEmpty: Bool {
        switch self {
        case .none:
            return true
        case .some(let value):
            return value.isEmpty
        }
    }
}

extension Collection {
    /// Return object at index if inside bounds, `nil` otherwise
    public subscript(safe index: Index) -> Iterator.Element? {
        return indices.contains(index) ? self[index] : nil
    }
}

extension Collection where Index: Strideable, Index.Stride: SignedInteger {
    /// Return objects in given range
    public subscript(safe range: CountableRange<Index>) -> Array<Element> {
        return range.compactMap { self[safe: $0] }
    }
}
