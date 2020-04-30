import Foundation

public extension Date {
    /// - Parameters:
    ///     - min: Minimum `timeIntervalSince1970`
    ///     - max: Maxium `timeIntervalSince1970`
    /// - Returns: Random date
    static func random(min: Int = 0, max: Int = 2000000000) -> Date {
        return Date(timeIntervalSince1970: TimeInterval(Int.random(min: min, max: max)))
    }
}

public extension Collection where Element == Date {
    /// - Parameters:
    ///     - min: Minimal number of returned elements
    ///     - max: Maximal number of returned elements
    /// - Returns: Array of random Dates
    static func random(min: Int = 20, max: Int = 100) -> [Element] {
        assert(min <= max, "Min must be smaller than max")
        let count = (Int.random() % max) + min
        return (0..<count).map { _ in .random() }
    }
}
