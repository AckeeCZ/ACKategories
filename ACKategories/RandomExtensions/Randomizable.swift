import Foundation

/// Mark a type Randomizable
/// to get automatically synthesized `.random()` method for `Collection`s
public protocol Randomizable {
    /// - Returns: Random instance of `Self`
    static func random() -> Self
}

public extension Collection where Element: Randomizable {
    /// - Parameters:
    ///     - min: Minimal number of returned elements
    ///     - max: Maximal number of returned elements
    /// - Returns: Array of random elements
    static func random(min: Int = 20, max: Int = 100) -> [Element] {
        let count = Int.random(in: min...max)
        return (0..<count).map { _ in .random() }
    }
}
