//
//  FoundationExtensions.swift
//  Pods
//
//  Created by Tomas Holka on 29/06/2017.
//
//

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
    
    
    // Removes nils from dictionary
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

