import Foundation

extension NumberFormatter {
    public func string(from number: Int) -> String? {
        return string(from: NSNumber(value: number))
    }

    public func string(from double: Double) -> String? {
        return string(from: NSNumber(value: double))
    }
}
