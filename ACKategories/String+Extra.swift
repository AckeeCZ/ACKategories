import Foundation

extension String {
    /// Returns first letter of self
    public var firstLetter: String? {
        guard count > 0 else { return nil }
        return self.first.flatMap { String($0) }
    }
    
    /// Returns true if string contains just numeric characters
    public var isNumeric: Bool {
        return !isEmpty && rangeOfCharacter(from: CharacterSet.decimalDigits.inverted) == nil
    }
    
    /// Uses self as key to Localizable.strings and returns it's localized value or self
    public func localized() -> String {
        return NSLocalizedString(self, comment: "")
    }

    /// Removes whitespaces from the start and end of self
    public func trimmed() -> String {
        return trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
    }
    
    /// Normalizes string - removes interpuction etc.
    public func normalized() -> String {
        let mutableString = NSMutableString(string: self) as CFMutableString
        CFStringTransform(mutableString, nil, kCFStringTransformToLatin, false)
        CFStringTransform(mutableString, nil, kCFStringTransformStripCombiningMarks, false)
        CFStringLowercase(mutableString, Locale.current as CFLocale)
        return mutableString as String
    }
    
    /// Returns **true** if `self` matches `regex`
    public func matchesRegex(_ regex: String) -> Bool {
        let test = NSPredicate(format: "SELF MATCHES %@", regex)
        return test.evaluate(with: self)
    }
}

// MARK: - Deprecations

extension String {
    @available(*, renamed: "normalized()")
    public func normalizedValue() -> String {
        return normalized()
    }
}
