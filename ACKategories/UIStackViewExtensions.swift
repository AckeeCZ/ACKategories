import UIKit

@available(iOS 9.0, *)
extension UIStackView {
    /// Remove all arranged subviews
    public func removeAllArrangedSubviews() {
        arrangedSubviews.forEach { removeArrangedSubview($0); $0.removeFromSuperview() }
    }
}
