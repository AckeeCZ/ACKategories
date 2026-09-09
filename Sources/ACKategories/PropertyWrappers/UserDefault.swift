import Combine
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
public final class UserDefault<Value: Codable> {
    private let key: String
    private let defaultValue: Value
    private let userDefaults: UserDefaults
    private let errorLogger: ((Error) -> Void)?
    private let subject: CurrentValueSubject<Value, Never>

    /// - Parameters:
    ///     - key: Key for which the value should be saved
    ///     - default: Default value to be used
    ///     - userDefaults: `UserDefaults` where value should be saved into. Default is `UserDefaults.standard`
    ///     - errorLogger: Closure that is triggered with error from encoding/decoding values from setter/getter and from the initial read in `init`
    public init(
        _ key: String,
        `default`: Value,
        userDefaults: UserDefaults = .standard,
        errorLogger: ((Error) -> Void)? = { print($0) }
    ) {
        self.key = key
        self.defaultValue = `default`
        self.userDefaults = userDefaults
        self.errorLogger = errorLogger
        self.subject = CurrentValueSubject(
            Self.storedValue(forKey: key, in: userDefaults, default: `default`, errorLogger: errorLogger)
        )
    }

    public var wrappedValue: Value {
        get {
            Self.storedValue(forKey: key, in: userDefaults, default: defaultValue, errorLogger: errorLogger)
        }
        set {
            if Value.self is PropertyListValue.Type {
                userDefaults.set(newValue, forKey: key)
            } else {
                let encoder = JSONEncoder()
                do {
                    let data = try encoder.encode([newValue])
                    userDefaults.set(data, forKey: key)
                } catch {
                    errorLogger?(error)
                    // Nothing was persisted, so publishing would leave subscribers
                    // holding a value `wrappedValue` never returns
                    return
                }
            }

            subject.send(newValue)
        }
    }

    public var projectedValue: AnyPublisher<Value, Never> {
        subject.eraseToAnyPublisher()
    }

    /// Reads the persisted value for `key`, falling back to `default` when it is missing or cannot be decoded.
    ///
    /// Static so `init` can seed `subject` before `self` is fully initialized.
    private static func storedValue(
        forKey key: String,
        in userDefaults: UserDefaults,
        `default` defaultValue: Value,
        errorLogger: ((Error) -> Void)?
    ) -> Value {
        // Check if `Value` is supported by default by `UserDefaults`
        if Value.self is PropertyListValue.Type {
            return userDefaults.object(forKey: key) as? Value ?? defaultValue
        } else {
            guard let data = userDefaults.object(forKey: key) as? Data else { return defaultValue }
            let decoder = JSONDecoder()
            // Values are wrapped in an array so the JSON has a root object.
            // Do not unwrap this — it would break decoding of everything already
            // persisted by earlier versions. See https://github.com/AckeeCZ/ACKategories/issues/89
            do {
                return try decoder.decode([Value].self, from: data).first ?? defaultValue
            } catch {
                errorLogger?(error)
                return defaultValue
            }
        }
    }
}

public extension UserDefault {
    convenience init<Wrapped>(_ key: String, `default`: Wrapped? = nil, userDefaults: UserDefaults = .standard) where Value == Wrapped? {
        self.init(key, default: `default`, userDefaults: userDefaults)
    }
}

/// Taken from: https://github.com/guillermomuntaner/Burritos/blob/master/Sources/UserDefault/UserDefault.swift
/// A type than can be stored in `UserDefaults`.
///
/// - From UserDefaults;
/// The value parameter can be only property list objects: NSData, NSString, NSNumber, NSDate, NSArray, or NSDictionary.
/// For NSArray and NSDictionary objects, their contents must be property list objects. For more information, see What is a
/// Property List? in Property List Programming Guide.
public protocol PropertyListValue {}

extension Data: PropertyListValue {}
extension NSData: PropertyListValue {}

extension String: PropertyListValue {}
extension NSString: PropertyListValue {}

extension Date: PropertyListValue {}
extension NSDate: PropertyListValue {}

extension NSNumber: PropertyListValue {}
extension Bool: PropertyListValue {}
extension Int: PropertyListValue {}
extension Int8: PropertyListValue {}
extension Int16: PropertyListValue {}
extension Int32: PropertyListValue {}
extension Int64: PropertyListValue {}
extension UInt: PropertyListValue {}
extension UInt8: PropertyListValue {}
extension UInt16: PropertyListValue {}
extension UInt32: PropertyListValue {}
extension UInt64: PropertyListValue {}
extension Double: PropertyListValue {}
extension Float: PropertyListValue {}

extension Array: PropertyListValue where Element: PropertyListValue {}

extension Dictionary: PropertyListValue where Key == String, Value: PropertyListValue {}
