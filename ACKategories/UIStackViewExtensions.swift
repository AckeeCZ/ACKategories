import UIKit

@available(iOS 9.0, *)
extension UIStackView {
    public func removeAllArrangedSubviews() {
        arrangedSubviews.forEach { removeArrangedSubview($0); $0.removeFromSuperview() }
    }
}
