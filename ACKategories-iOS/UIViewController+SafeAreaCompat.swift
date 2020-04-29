import UIKit

@available(iOS 9.0, *)
extension UIViewController {
    private enum Keys {
        static var safeArea: UInt8 = 0
    }

    /// Layout guide compatibility extension for iOS 11 safe area
    ///
    /// On iOS 11+ is the same as `view.safeAreaLayoutGuide`.
    ///
    /// On older systems it fallbacks to `topLayoutGuide.bottom` and `bottomLayoutGuide.top`, side constraints are equal to superview.
    @available(iOS, deprecated: 11, renamed: "view.safeAreaLayoutGuide")
    public var safeArea: UILayoutGuide {
        if #available(iOS 11.0, *) {
            return view.safeAreaLayoutGuide
        } else {
            if let layoutGuide = objc_getAssociatedObject(self, &Keys.safeArea) as? UILayoutGuide { return layoutGuide }

            let layoutGuide = UILayoutGuide()
            view.addLayoutGuide(layoutGuide)
            layoutGuide.topAnchor.constraint(equalTo: topLayoutGuide.bottomAnchor).isActive = true
            layoutGuide.bottomAnchor.constraint(equalTo: bottomLayoutGuide.topAnchor).isActive = true
            layoutGuide.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
            layoutGuide.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
            objc_setAssociatedObject(self, &Keys.safeArea, layoutGuide, .OBJC_ASSOCIATION_ASSIGN)
            return layoutGuide
        }
    }
}
