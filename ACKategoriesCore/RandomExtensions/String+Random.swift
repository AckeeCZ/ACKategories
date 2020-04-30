import Foundation

extension String: Randomizable {
    public static func random() -> String {
        String.random(minLength: 5)
    }

    /// - Parameters:
    ///     - minLength: Minimum length of a returned String
    ///     - maxLength: Maxium length of a returned String
    ///     - allowedLetters: Letters that will be used in the randomization
    /// - Returns: Randomized String
    public static func random(minLength: Int = 5,
                              maxLength: Int = 10,
                              allowedLetters: String = "abcdefghijklmnopqrstuvwxyzěščřžýáíéABCDEFGHIJKLMNOPQRSTUVWXYZĚŠČŘŽÝÁÍÉ0123456789") -> String {
        let length = Int.random(in: minLength...maxLength)
        return (0..<length).map { _ in
            let position = Int.random(in: 0..<allowedLetters.count)
            let index = allowedLetters.index(allowedLetters.startIndex, offsetBy: position)
            return String(allowedLetters[index])
        }
        .joined()
    }
}
