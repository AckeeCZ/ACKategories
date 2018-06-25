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
