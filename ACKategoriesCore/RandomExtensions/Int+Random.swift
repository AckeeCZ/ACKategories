import Foundation

public extension Int {
    /// - Parameters:
    ///     - min: Minimal value of returned Int
    ///     - max: Maximal value of returned Int
    /// - Returns random Int
    static func random(min: Int = 20, max: Int = 1000) -> Int {
        assert(min <= max, "Min must be smaller than max")
        return Int(arc4random_uniform(UInt32(max - min + 1))) + min
    }
}

public extension Collection where Element == Int {
    /// - Parameters:
    ///     - min: Minimal number of returned elements
    ///     - max: Maximal number of returned elements
    /// - Returns: Array of random Ints
    static func random(min: Int = 20, max: Int = 100) -> [Element] {
        assert(min <= max, "Min must be smaller than max")
        let count = (Int.random() % max) + min
        return (0..<count).map { _ in .random() }
    }
}
