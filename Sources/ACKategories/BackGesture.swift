#if os(iOS)
import UIKit

private class BackGestureDelegate: NSObject {
    // MARK: - Private properties

    private weak var navigationController: UINavigationController?

    // MARK: Initializers

    init(
        navigationController: UINavigationController
    ) {
        super.init()
        self.navigationController = navigationController
    }
}

// MARK: - UIGestureRecognizerDelegate
extension BackGestureDelegate: UIGestureRecognizerDelegate {
    func gestureRecognizerShouldBegin(_ gestureRecognizer: UIGestureRecognizer) -> Bool {
        navigationController.map { $0.viewControllers.count > 1 } ?? false
    }
}

extension UINavigationController {
    private enum Keys {
        static var backGestureDelegate: UInt8 = 0
    }

    private var backGestureDelegate: BackGestureDelegate {
        if let delegate = objc_getAssociatedObject(self, &Keys.backGestureDelegate) as? BackGestureDelegate {
            return delegate
        }

        let delegate = BackGestureDelegate(navigationController: self)
        objc_setAssociatedObject(
            self,
            &Keys.backGestureDelegate,
            delegate,
            .OBJC_ASSOCIATION_RETAIN
        )
        return delegate
    }

    /// Add custom interactivePopGestureRecognizer delegate so it works even with hidden navigationBar
    public func setupCustomBackGestureDelegate() {
        assert(isViewLoaded, "View needs to be already loaded")
        assert(
            interactivePopGestureRecognizer != nil,
            "Cannot install gesture delegate on nil recognizer"
        )
        interactivePopGestureRecognizer?.delegate = backGestureDelegate
    }
}
#endif
