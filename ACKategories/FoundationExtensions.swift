import Foundation

public protocol OptionalProtocol {
    associatedtype WrappedValue
    var optional: WrappedValue? {get}
}

extension Optional: OptionalProtocol {
    public typealias WrappedValue = Wrapped
    public var optional: WrappedValue? { return self }
}

extension Dictionary where Value: OptionalProtocol {
    
    /// Removes nils from dictionary
    public var nilsRemoved: [Key: Value.WrappedValue] {
        return self.reduce([:]) { acc, element -> [Key: Value.WrappedValue] in
            
            if let value = element.value.optional {
                var result = acc
                result[element.key] = value
                return result
            } else {
                return acc
            }
        }
    }
    
    /**
     Simulation of classic valueForKeyPath method.
     
     - Parameter keyPath: Dot separated key path
     */
    public func value<T>(for keyPath: String) -> T? {
        let components = keyPath.components(separatedBy: ".")
        
        var result: Any? = self
        components.forEach { key in
            guard let key = key as? Key else {
                return
            }
            result = (result as? Dictionary<Key, Value>)?[key]
        }
        return result as? T
    }
}

extension Optional where Wrapped: Collection {
    /// Return `true` if `self` is empty or nil
    public var isEmpty: Bool {
        switch self {
        case .none:
            return true
        case .some(let value):
            return value.isEmpty
        }
    }
}

extension NumberFormatter {
    public func string(from number: Int) -> String? {
        return string(from: NSNumber(value: number))
    }
    
    public func string(from double: Double) -> String? {
        return string(from: NSNumber(value: double))
    }
}

/// Merge two dictionaries, if `lhs` contains same key as `rhs` it will be overwritten by `rhs` value
public func +<Key, Value> (lhs: [Key: Value], rhs: [Key: Value]) -> [Key: Value] {
    var result = lhs
    for (k, v) in rhs { result.updateValue(v, forKey: k) }
    return result
}

extension Array where Element: Equatable {
    /// Remove given object
    public mutating func remove(object: Element) {
        if let index = index(of: object) {
            remove(at: index)
        }
    }
}

extension Bundle {
    /// Get receipt data
    public var receiptData: Data? { return appStoreReceiptURL.flatMap { try? Data(contentsOf: $0) } }
    
    /// Get `CFBundleShortVersionString`
    public var version: String? { return infoDictionary?["CFBundleShortVersionString"] as? String }
    
    /// Get `CFBundleVersion`
    public var buildNumber: Int? { return (infoDictionary?["CFBundleVersion"] as? String).flatMap { Int($0) } }
}

extension TimeInterval {
    /// One minute
    public static var minute: TimeInterval { return TimeInterval(60) }
    
    /// One hour
    public static var hour: TimeInterval { return minute * 60 }
    
    /// One day
    public static var day: TimeInterval { return hour * 24 }
}
