//
//  UILabelExtensions.swift
//  ACKategories
//
//  Created by Jakub Olejník on 13/04/2018.
//  Copyright © 2018 Josef Dolezal. All rights reserved.
//

import UIKit

extension UILabel {
    /// Get or set font size keeping current font
    public var fontSize: CGFloat {
        get { return font.pointSize }
        set { font = font.withSize(newValue) }
    }
}
