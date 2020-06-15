import Foundation

/// A type safe property wrapper to set and get values from UserDefaults with support for defaults values.
///
/// Usage:
/// ```
/// @UserDefault("has_seen_app_introduction", default: false)
/// var hasSeenAppIntroduction: Bool
/// ```
///
/// [Apple documentation on UserDefaults](https://developer.apple.com/documentation/foundation/userdefaults)
@propertyWrapper
public struct UserDefault<Value: Codable> {
    let key: String
    let defaultValue: Value
    var userDefaults: UserDefaults

    /// - Parameters:
    ///     - key: Key for which the value should be saved
    ///     - default: Default value to be used
    ///     - userDefaults: `UserDefaults` where value should be saved into. Default is `UserDefaults.standard`
    public init(_ key: String, `default`: Value, userDefaults: UserDefaults = .standard) {
        self.key = key
        self.defaultValue = `default`
        self.userDefaults = userDefaults
    }

    public var wrappedValue: Value {
        get {
            guard let data = userDefaults.object(forKey: key) as? Data else { return defaultValue }
            let decoder = JSONDecoder()
            return (try? decoder.decode(Value.self, from: data)) ?? defaultValue
        }
        set {
            let encoder = JSONEncoder()
            let data = try? encoder.encode(newValue)
            userDefaults.set(data, forKey: key)
        }
    }
}

public extension UserDefault {
    init<Wrapped>(_ key: String, `default`: Optional<Wrapped> = nil, userDefaults: UserDefaults = .standard) where Value == Optional<Wrapped> {
        self.init(key, default: `default`, userDefaults: userDefaults)
    }
}
