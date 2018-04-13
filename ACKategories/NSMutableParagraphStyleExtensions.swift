//
//  NSMutableParagraphStyleExtensions.swift
//  ACKategories
//
//  Created by Jakub Olejník on 13/04/2018.
//  Copyright © 2018 Josef Dolezal. All rights reserved.
//

import UIKit

extension NSMutableParagraphStyle {
    /// Create new paragraphStyle with given line height
    public convenience init(lineHeight: CGFloat) {
        self.init()
        maximumLineHeight = lineHeight
        minimumLineHeight = lineHeight
    }
}
