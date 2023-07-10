import UIKit

/// Extend you container controllers with this protocol, to make sure `frontmostChild` and `frontmostController` properties
/// can work correctly
public protocol FrontmostContainerViewController {
    /// Goes through view controller hierarchy and returns view controller on top
    var frontmostChild: UIViewController? { get }
}

extension UISplitViewController: FrontmostContainerViewController {
    public var frontmostChild: UIViewController? { viewControllers.last }
}

extension UINavigationController: FrontmostContainerViewController {
    public var frontmostChild: UIViewController? { topViewController }
}

extension UITabBarController: FrontmostContainerViewController {
    public var frontmostChild: UIViewController? { selectedViewController }
}

public extension UIViewController {
    /// Returns frontmost controller that can be used e.g. for modal presentations
    var frontmostController: UIViewController {
        presentedViewController?.frontmostController ?? (self as? FrontmostContainerViewController)?.frontmostChild?.frontmostController ?? self
    }
}
