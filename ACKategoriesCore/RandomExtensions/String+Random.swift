import Foundation

public extension String {
    /// - Parameters:
    ///     - minLength: Minimum length of a returned String
    ///     - maxLength: Maxium length of a returned String
    ///     - allowedLetters: Letters that will be used in the randomization
    /// - Returns: Randomized String
    static func random(minLength: Int = 5,
                       maxLength: Int = 10,
                       allowedLetters: String = "abcdefghijklmnopqrstuvwxyzěščřžýáíéABCDEFGHIJKLMNOPQRSTUVWXYZĚŠČŘŽÝÁÍÉ0123456789") -> String {
        let length = (Int.random() % maxLength) + minLength
        return (0...length).map { _ in
            let rand = arc4random_uniform(UInt32(allowedLetters.count))
            var nextChar = (allowedLetters as NSString).character(at: Int(rand))
            return NSString(characters: &nextChar, length: 1) as String
        }
        .joined()
    }
}

public extension Collection where Element == String {
    /// - Parameters:
    ///     - min: Minimal number of returned elements
    ///     - max: Maximal number of returned elements
    /// - Returns: Array of random Strings
    static func random(min: Int = 20, max: Int = 100) -> [Element] {
        assert(min <= max, "Min must be smaller than max")
        let count = (Int.random() % max) + min
        return (0..<count).map { _ in .random() }
    }
}
