#if canImport(UIKit) && !os(watchOS)
import UIKit

extension UILabel {
    /// Get or set font size keeping current font
    public var fontSize: CGFloat {
        get { return font.pointSize }
        set { font = font.withSize(newValue) }
    }
}
#endif
