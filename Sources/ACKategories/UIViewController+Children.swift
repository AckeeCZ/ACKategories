#if canImport(UIKit) && !os(watchOS)
import UIKit

extension UIViewController {

    /// Display `childViewController` in given `view`.
    ///
    /// If `view` is `nil` (by default) then controller is displayed in `self.view`.
    public func display(childViewController: UIViewController, in view: UIView? = nil) {
        guard
            let view = view ?? self.view,
            let childView = childViewController.view
        else { return }

        view.translatesAutoresizingMaskIntoConstraints = false
        childViewController.view.translatesAutoresizingMaskIntoConstraints = false

        childViewController.willMove(toParent: self)
        addChild(childViewController)
        view.addSubview(childViewController.view)
        view.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "|[view]|", options: NSLayoutConstraint.FormatOptions(rawValue: 0), metrics: nil, views: ["view": childView]))
        view.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|[view]|", options: NSLayoutConstraint.FormatOptions(rawValue: 0), metrics: nil, views: ["view": childView]))
        childViewController.didMove(toParent: self)
    }

    /// Remove child view controller from controller hierarchy, nothing happens if `self` is not `parent` of `childViewController`
    public func remove(childViewController: UIViewController) {
        guard childViewController.parent === self else { return }

        childViewController.willMove(toParent: nil)
        childViewController.view.removeFromSuperview()
        childViewController.removeFromParent()
        childViewController.didMove(toParent: nil)
    }
}
#endif
