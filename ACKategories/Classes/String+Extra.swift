extension String {
    /// Uses self as key to Localizable.strings and returns it's localized value or self
    public var localized: String {
        return NSLocalizedString(self, comment: "")
    }

    /// Removes whitespaces from the start and end of self
    public var trimmed: String {
        return stringByTrimmingCharactersInSet(NSCharacterSet.whitespaceAndNewlineCharacterSet())
    }

    /// Returns number of characters in self
    public var length: Int {
        return characters.count
    }

    /// Returns first letter of self
    public var firstLetter: String? {
        guard length > 0 else { return nil }
        return substringToIndex(startIndex.successor())
    }
}