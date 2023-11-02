import UIKit

public extension UIColor {
    /**
     Initialize color from hex int (eg. 0xff00ff).

     - parameter hex: Hex int to create color from
     */
    convenience init(hex: UInt32) {
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
    convenience init(hexString: String) {
        var rgbValue: UInt32 = 0
        let scanner = Scanner(string: hexString)
        scanner.scanLocation = 1 // bypass '#' character
        scanner.scanHexInt32(&rgbValue)
        self.init(hex: rgbValue)
    }

    /**
     Returns color as hex string (eg. '#ff00ff') or nil if RGBA components couldn't be loaded.
     Monochrome check included (works for white/black/clear).
     */
    var hexString: String? {
        guard let components = cgColor.components, cgColor.numberOfComponents > 1 else { return nil }
        let isMonochrome = cgColor.colorSpace?.model == .monochrome

        let r: CGFloat = isMonochrome ? components[0] : components[0]
        let g: CGFloat = isMonochrome ? components[0] : components[1]
        let b: CGFloat = isMonochrome ? components[0] : components[2]

        return String(format: "#%02lX%02lX%02lX", lroundf(Float(r * 255)), lroundf(Float(g * 255)), lroundf(Float(b * 255)))
    }

    /// Create random color
    static func random() -> UIColor {
        let randomRed = CGFloat(arc4random()) / CGFloat(UInt32.max)
        let randomGreen = CGFloat(arc4random()) / CGFloat(UInt32.max)
        let randomBlue = CGFloat(arc4random()) / CGFloat(UInt32.max)

        return UIColor(red: randomRed, green: randomGreen, blue: randomBlue, alpha: 1.0)
    }

    /**
     Make color lighter with defined amount.
     
     - parameter amount: Defines how much lighter color is returned. Should be from 0.0 to 1.0
     */
    func brightened(by amount: CGFloat = 0.25) -> UIColor {
        return with(brightnessAmount: 1 + max(0, amount))
    }

    /**
     Make color darker with defined amount.
     
     - parameter amount: Defines how much darker color is returned. Should be from 0.0 to 1.0
     */
    func darkened(by amount: CGFloat = 0.25) -> UIColor {
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
    var isLight: Bool {

        guard let components = cgColor.components else { return true }
        let red = components[0]
        let green = components[1]
        let blue = components[2]
        let brightness = (red * 299 + green * 587 + blue * 114) / 1000

        return brightness > 0.5
    }

    /// Returns true for dark colors. When dark color is used as background, you should use white as a text color.
    var isDark: Bool {
        return !isLight
    }

    /// Create image from color with defined size.
    func image(of size: CGSize = CGSize(width: 1, height: 1)) -> UIImage {
        let rect = CGRect(x: 0, y: 0, width: size.width, height: size.height)
        UIGraphicsBeginImageContext(size)
        let context = UIGraphicsGetCurrentContext()

        if #available(iOS 13.0, *) {
            // if self has alpha < 1 then this alpha is correctly applied on content
            // during context rendering, which is right behavior. But after that in
            // `.withTintColor(self)` below, this alpha is applied again and resulting
            // image is more transparent then it should be. So use any non-transparent
            // color here to draw the content and set resulting color with alpha only below.
            context?.setFillColor(UIColor.white.cgColor)
        } else {
            context?.setFillColor(self.cgColor)
        }
        context?.fill(rect)

        // swiftlint:disable:next force_unwrapping
        let image = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()

        if #available(iOS 13.0, *) {
            return image.withTintColor(self)
        } else {
            return image
        }
    }
}
