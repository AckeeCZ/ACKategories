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

extension Optional where Wrapped == String {
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
        return self.string(from: NSNumber(value: number))
    }
}

func +<Key, Value> (lhs: [Key: Value], rhs: [Key: Value]) -> [Key: Value] {
    var result = lhs
    for (k, v) in rhs { result.updateValue(v, forKey: k) }
    return result
}
