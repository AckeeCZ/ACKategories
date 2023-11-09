#if canImport(UIKit)
import UIKit

extension UIStackView {
    /// Remove all arranged subviews
    public func removeAllArrangedSubviews() {
        arrangedSubviews.forEach { removeArrangedSubview($0); $0.removeFromSuperview() }
    }
}
#endif
