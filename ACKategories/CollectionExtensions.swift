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

    /// Return `true` if `self` is not empty and not nil
    public var isNotEmpty: Bool {
        switch self {
        case .none:
            return false
        case .some(let value):
            return !value.isEmpty
        }
    }

    /// Return `self` if it is not empty and not nil, otherwise return nil
    public var nonEmpty: Wrapped? {
        return self?.isEmpty == true ? nil : self
    }
}

extension Collection {
    /// Return object at index if inside bounds, `nil` otherwise
    public subscript(safe index: Index) -> Iterator.Element? {
        return indices.contains(index) ? self[index] : nil
    }

    /// Return `true` if `self` is not empty
    public var isNotEmpty: Bool {
        return !isEmpty
    }
}

extension Collection where Index: Strideable, Index.Stride: SignedInteger {
    /// Return objects in given range
    public subscript(safe range: CountableRange<Index>) -> Array<Element> {
        return range.compactMap { self[safe: $0] }
    }
}
