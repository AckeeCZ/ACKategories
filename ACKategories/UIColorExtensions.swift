import UIKit

public extension UIColor {
    /**
     Initialize color from hex int (eg. 0xff00ff).

     - parameter hex: Hex int to create color from
     */
    public convenience init(hex: UInt32) {
        self.init(
            red: CGFloat(Double((hex & 0xFF0000) >> 16) / 255.0),
            green: CGFloat(Double((hex & 0xFF00) >> 8) / 255.0),
            blue: CGFloat(Double(hex & 0xFF) / 255.0),
            alpha: 1.0
        )
    }

    /**
     Initialize color from hex string (eg. "#ff00ff"). Leading '#' is mandatory.

     - parameter hexString: Hex string to create color from
     */
    public convenience init(hexString: String) {
        var rgbValue: UInt32 = 0
        let scanner = Scanner(string: hexString)
        scanner.scanLocation = 1 // bypass '#' character
        scanner.scanHexInt32(&rgbValue)
        self.init(hex: rgbValue)
    }

    /// Create random color
    public static func random() -> UIColor {
        let randomRed = CGFloat(arc4random()) / CGFloat(UInt32.max)
        let randomGreen = CGFloat(arc4random()) / CGFloat(UInt32.max)
        let randomBlue = CGFloat(arc4random()) / CGFloat(UInt32.max)

        return UIColor(red: randomRed, green: randomGreen, blue: randomBlue, alpha: 1.0)
    }

    /**
     Make color lighter with defined amount.
     
     - parameter amount: Defines how much lighter color is returned. Should be from 0.0 to 1.0
     */
    public func brightened(by amount: CGFloat = 0.25) -> UIColor {
        return with(brightnessAmount: 1 + max(0, amount))
    }

    /**
     Make color darker with defined amount.
     
     - parameter amount: Defines how much darker color is returned. Should be from 0.0 to 1.0
     */
    public func darkened(by amount: CGFloat = 0.25) -> UIColor {
        return with(brightnessAmount: 1 - max(0, amount))
    }

    fileprivate func with(brightnessAmount: CGFloat) -> UIColor {
        var h: CGFloat = 0
        var s: CGFloat = 0
        var b: CGFloat = 0
        var a: CGFloat = 0

        guard getHue(&h, saturation: &s, brightness: &b, alpha: &a) else { return self }

        return UIColor(
            hue: h,
            saturation: s,
            brightness: b * brightnessAmount,
            alpha: a
        )
    }

    /// Returns true for light colors. When light color is used as background, you should use black as a text color.
    public var isLight: Bool {

        let components = self.cgColor.components
        let red = components?[0]
        let green = components?[1]
        let blue = components?[2]
        let brightness = (red! * 299 + green! * 587 + blue! * 114) / 1000

        return brightness > 0.5
    }

    /// Returns true for dark colors. When dark color is used as background, you should use white as a text color.
    public var isDark: Bool {
        return !isLight
    }

    /// Create image from color with defined size.
    public func image(of size: CGSize = CGSize(width: 1, height: 1)) -> UIImage {
        let rect = CGRect(x: 0, y: 0, width: size.width, height: size.height)
        UIGraphicsBeginImageContext(size)
        let context = UIGraphicsGetCurrentContext()

        context?.setFillColor(self.cgColor)
        context?.fill(rect)

        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()

        return image!
    }
}
