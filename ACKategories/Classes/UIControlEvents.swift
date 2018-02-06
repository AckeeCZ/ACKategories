import UIKit

extension UIControlEvents {
    /// Combined event for `.touchUpOutside`, `.touchUpInside`, `.touchCancel`
    public static let touchEndEvents: UIControlEvents = [.touchUpOutside, .touchUpInside, .touchCancel]
}
