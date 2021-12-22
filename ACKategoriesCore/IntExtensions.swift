import Foundation
import CoreGraphics

public extension Int {
    /// Optionally create `Int` checking if `double` is not Nan nor infinity
    init?(safe double: Double) {
        if double.isNaN || double.isInfinite {
            return nil
        }

        self.init(double)
    }

    /// Optionally create `Int` checking if `float` is not Nan nor infinity
    init?(safe float: Float) {
        if float.isNaN || float.isInfinite {
            return nil
        }

        self.init(float)
    }

    /// Optionally create `Int` checking if `cgFloat` is not Nan nor infinity
    init?(safe cgFloat: CGFloat) {
        if cgFloat.isNaN || cgFloat.isInfinite {
            return nil
        }

        self.init(cgFloat)
    }
}
