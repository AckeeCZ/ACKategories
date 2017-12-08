import Foundation

precedencegroup ConditionalAssignmentPrecedence {
    associativity: left
    assignment: true
    higherThan: AssignmentPrecedence
}

infix operator =?: ConditionalAssignmentPrecedence

public func =?<T>(variable: inout T, value: T?) {
    if let v = value {
        variable = v
    }
}
