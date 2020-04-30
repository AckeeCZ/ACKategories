//
//  UIView+SafeAreaCompat.swift
//  ACKategories
//
//  Created by Jakub Olejník on 06/02/2018.
//  Copyright © 2018 Josef Dolezal. All rights reserved.
//

import UIKit

@available(iOS 9.0, *)
extension UIView {
    private enum Keys {
        static var safeArea: UInt8 = 0
    }

    /// Layout guide compatibility extension for iOS 11 safe area
    ///
    /// On iOS 11+ is the same as `safeAreaLayoutGuide`.
    ///
    /// On older systems it fallbacks to superview bounds
    @available(iOS, deprecated: 11, renamed: "safeAreaLayoutGuide")
    public var safeArea: UILayoutGuide {
        if #available(iOS 11.0, *) {
            return safeAreaLayoutGuide
        } else {
            if let layoutGuide = objc_getAssociatedObject(self, &Keys.safeArea) as? UILayoutGuide { return layoutGuide }

            let layoutGuide = UILayoutGuide()
            addLayoutGuide(layoutGuide)
            layoutGuide.topAnchor.constraint(equalTo: topAnchor).isActive = true
            layoutGuide.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
            layoutGuide.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
            layoutGuide.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
            objc_setAssociatedObject(self, &Keys.safeArea, layoutGuide, .OBJC_ASSOCIATION_ASSIGN)
            return layoutGuide
        }
    }
}
