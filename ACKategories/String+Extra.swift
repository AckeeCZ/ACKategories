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
    
    /// Check if `self` is valid email with default regex
    public func isValidEmail(emailRegex: String = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}") -> Bool {
        return matchesRegex(emailRegex)
    }
    
    /// Fill string with padding character to mach given length
    public func leftPadding(toLength: Int, withPad character: Character) -> String {
        let stringLength = self.count
        if stringLength < toLength {
            return String(repeatElement(character, count: toLength - stringLength)) + self
        } else {
            return String(self.suffix(toLength))
        }
    }
    
    /// Remove given character from the beginning
    public func removeLeftPadding(pad: Character) -> String {
        return reduce("") {
            guard $0.isEmpty else { return $0 + String($1) }
            return $1 == pad ? $0 : $0 + String($1)
        }
    }
}

// MARK: - Deprecations

extension String {
    @available(*, renamed: "normalized()")
    public func normalizedValue() -> String {
        return normalized()
    }
}
