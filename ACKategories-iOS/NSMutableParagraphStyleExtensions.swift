import UIKit

extension NSMutableParagraphStyle {
    /// Create new paragraphStyle with given line height
    public convenience init(lineHeight: CGFloat) {
        self.init()
        maximumLineHeight = lineHeight
        minimumLineHeight = lineHeight
    }
}
