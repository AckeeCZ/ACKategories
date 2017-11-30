import UIKit

extension UIButton {
    
    open override var intrinsicContentSize: CGSize {
        let size = super.intrinsicContentSize
        let width = size.width + titleEdgeInsets.left + titleEdgeInsets.right
        let height = size.height + titleEdgeInsets.top + titleEdgeInsets.bottom
        return CGSize(width: width, height: height)
    }
    
}
