import UIKit

extension UIControl.Event {
    /// Combined event for `.touchUpOutside`, `.touchUpInside`, `.touchCancel`
    public static let touchEndEvents: UIControl.Event = [.touchUpOutside, .touchUpInside, .touchCancel]
}
