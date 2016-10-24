extension String {
    /// Uses self as key to Localizable.strings and returns it's localized value or self
    public func localized() -> String {
        return NSLocalizedString(self, comment: "")
    }

    /// Removes whitespaces from the start and end of self
    public func trimmed() -> String {
        return trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
    }

    /// Returns number of characters in self
    public var length: Int {
        return characters.count
    }

    /// Returns first letter of self
    public var firstLetter: String? {
        guard length > 0 else { return nil }
        return substring(to: characters.index(after: startIndex))
    }
}
