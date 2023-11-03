import UIKit

// not sure this doesn't crash on iOS 11, so make it unavailable as it cannot be really tested
@available(iOS 12, *)
public extension UIView {
    private final class Spacer: UIView {
        fileprivate var observation: NSKeyValueObservation?

        init(
            size: CGFloat,
            axis: NSLayoutConstraint.Axis,
            priority: Float
        ) {
            super.init(frame: .init(
                origin: .zero,
                size: .init(
                    width: axis == .horizontal ? size : 0,
                    height: axis == .vertical ? size : 0
                )
            ))

            translatesAutoresizingMaskIntoConstraints = false

            switch axis {
            case .horizontal:
                let constraint = widthAnchor.constraint(equalToConstant: size)
                constraint.priority = .init(priority)
                constraint.isActive = true
            case .vertical:
                let constraint = heightAnchor.constraint(equalToConstant: size)
                constraint.priority = .init(priority)
                constraint.isActive = true
            default: assertionFailure("Unknown axis \(axis)")
            }
        }

        required init?(coder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }
    }

    private func createSpacer(_ size: CGFloat, axis: NSLayoutConstraint.Axis, priority: Float) -> UIView {
        let spacer = Spacer(size: size, axis: axis, priority: priority)
        spacer.isHidden = isHidden
        spacer.observation = observe(\.isHidden) { [weak spacer] sender, _ in
            spacer?.isHidden = sender.isHidden
        }
        return spacer
    }

    /// Create vertical spacer whose `isHidden` is tied to `self.isHidden`
    func createVSpacer(_ height: CGFloat, priority: Float = 999) -> UIView {
        createSpacer(height, axis: .vertical, priority: priority)
    }

    /// Create horizontal spacer whose `isHidden` is tied to `self.isHidden`
    func createHSpacer(_ width: CGFloat, priority: Float = 999) -> UIView {
        createSpacer(width, axis: .horizontal, priority: priority)
    }
}
