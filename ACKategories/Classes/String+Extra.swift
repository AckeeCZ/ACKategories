import Foundation

extension String {
    /// Uses self as key to Localizable.strings and returns it's localized value or self
    public func localized() -> String {
        return NSLocalizedString(self, comment: "")
    }

    /// Removes whitespaces from the start and end of self
    public func trimmed() -> String {
        return trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
    }

    /// Returns first letter of self
    public var firstLetter: String? {
        guard count > 0 else { return nil }
        return self.first.flatMap { String($0) }
    }
    
    /// Normalizes string - removes interpuction etc.
    public func normalizedValue() -> String {
        let mutableString = NSMutableString(string: self) as CFMutableString
        CFStringTransform(mutableString, nil, kCFStringTransformToLatin, false)
        CFStringTransform(mutableString, nil, kCFStringTransformStripCombiningMarks, false)
        CFStringLowercase(mutableString, Locale.current as CFLocale!)
        return mutableString as String
    }
}
