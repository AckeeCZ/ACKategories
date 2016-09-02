//
//  Color+Extra.swift
//  Pods
//
//  Created by Jan Mísař on 31.08.16.
//
//

import UIKit

public extension UIColor {
    public convenience init(hex: UInt32) {
        self.init(
            red: CGFloat(Double((hex & 0xFF0000) >> 16) / 255.0),
            green: CGFloat(Double((hex & 0xFF00) >> 8) / 255.0),
            blue: CGFloat(Double(hex & 0xFF) / 255.0),
            alpha: 1.0
        )
    }

    public convenience init(hexString: String) {
        var rgbValue: UInt32 = 0
        let scanner = NSScanner(string: hexString)
        scanner.scanLocation = 1 // bypass '#' character
        scanner.scanHexInt(&rgbValue)
        self.init(hex: rgbValue)
    }

    public static var random: UIColor {
        let randomRed = CGFloat(arc4random()) / CGFloat(UInt32.max)
        let randomGreen = CGFloat(arc4random()) / CGFloat(UInt32.max)
        let randomBlue = CGFloat(arc4random()) / CGFloat(UInt32.max)

        return UIColor(red: randomRed, green: randomGreen, blue: randomBlue, alpha: 1.0)
    }

    public var isLight: Bool {

        let components = CGColorGetComponents(self.CGColor)
        let red = components[0]
        let green = components[1]
        let blue = components[2]
        let brightness = (red * 299 + green * 587 + blue * 114) / 1000

        return brightness > 0.5
    }

    public var isDark: Bool {
        return !isLight
    }
}
