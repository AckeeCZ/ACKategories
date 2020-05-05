import Foundation

extension Date: Randomizable {
    public static func random() -> Date {
        Date.random(min: 0)
    }

    /// - Parameters:
    ///     - min: Minimum `timeIntervalSince1970`
    ///     - max: Maxium `timeIntervalSince1970`
    /// - Returns: Random date
    public static func random(min: Int = 0, max: Int = Int.max) -> Date {
        Date(timeIntervalSince1970: TimeInterval(Int.random(in: min...max)))
    }
}
