#if canImport(UIKit) && !os(watchOS)
import UIKit

public extension UIView {
    /// Make `self` require its intrinsic size.
    ///
    /// Sets its `contentHuggingPriority` and `contentCompressionResistancePriority` to `UILayoutPriority.required`.
    func forceIntrinsic() {
        setContentHuggingPriority(.required, for: .horizontal)
        setContentHuggingPriority(.required, for: .vertical)
        setContentCompressionResistancePriority(.required, for: .horizontal)
        setContentCompressionResistancePriority(.required, for: .vertical)
    }
}
#endif
