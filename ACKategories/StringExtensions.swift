import Foundation

extension String {
    public enum Side {
        case both
        case leading
        case trailing
    }

    /// Returns first letter of self
    public var firstLetter: String? {
        guard count > 0 else { return nil }
        return self.first.flatMap { String($0) }
    }

    /// Returns true if string contains just numeric characters
    public var isNumeric: Bool {
        return !isEmpty && rangeOfCharacter(from: CharacterSet.decimalDigits.inverted) == nil
    }

    /// Uses `self` as key in stringsfile and returns its localized value or `self`
    ///
    /// - parameter comment: Comment to string usage, is displayed if `key` is missing in table and `value` is empty string
    /// - parameter value: Value to be displayed if `key` is missing, if empty string then `key` is displayed
    /// - parameter tableName: Name of strings table
    /// - parameter bundle: Bundle where localization table is stored
    public func localized(comment: String = "", value: String = "", tableName: String? = nil, bundle: Bundle = .main) -> String {
        NSLocalizedString(self, tableName: tableName, bundle: bundle, value: value, comment: comment)
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
    public func isValidEmail(regex: String = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}") -> Bool {
        return matchesRegex(regex)
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

    /// Removes characters in `characterSet` from sides of string
    public func trimmed(characterSet: CharacterSet = .whitespacesAndNewlines, from side: Side = .both) -> String {
        func leadingTrim(_ string: String) -> String {
            return string.reduce("") {
                guard $0.isEmpty else { return $0 + String($1) }
                return characterSet.isSuperset(of: CharacterSet(charactersIn: String($1))) ? $0 : $0 + String($1)
            }
        }

        switch side {
        case .both: return trimmingCharacters(in: characterSet)
        case .leading: return leadingTrim(self)
        case .trailing: return String(leadingTrim(String(reversed())).reversed())
        }
    }

    /// Removes characters in `characterSet` from sides of string
    public func trimmed(charactersIn string: String, from side: Side = .both) -> String {
        return trimmed(characterSet: CharacterSet(charactersIn: string), from: side)
    }

    /// Removes diacritics from string using given locale
    ///
    /// If no locale is given `Locale.current` is used
    public func removingDiacritics(_ locale: Locale = Locale.current) -> String {
        return folding(options: .diacriticInsensitive, locale: locale)
    }
}
