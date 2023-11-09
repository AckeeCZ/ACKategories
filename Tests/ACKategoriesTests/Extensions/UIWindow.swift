#if canImport(UIKit) && !os(watchOS)
import UIKit

extension UIWindow {
    static var dummy: UIWindow {
        UIWindow(frame: UIScreen.main.bounds)
    }
}
#endif
