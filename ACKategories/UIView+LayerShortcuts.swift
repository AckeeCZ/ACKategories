//
//  UIView+LayerShortcuts.swift
//  ACKategories
//
//  Created by Jan Misar on 13.05.18.
//  Copyright © 2018 Ackee, s.r.o.. All rights reserved.
//

import UIKit

public extension UIView {
    
    /// Shortcut for layer.cornerRadius
    var cornerRadius: CGFloat {
        get {
            return layer.cornerRadius
        }
        set {
            layer.cornerRadius = newValue
        }
    }
    
    /// Shortcut for layer.shadowColor
    var shadowColor: UIColor? {
        get {
            return layer.shadowColor.flatMap(UIColor.init)
        }
        set {
            layer.shadowColor = newValue?.cgColor
        }
    }
    
    /// Shortcut for layer.shadowOffset
    var shadowOffset: CGSize {
        get {
            return layer.shadowOffset
        }
        set {
            layer.shadowOffset = newValue
        }
    }
    
    /// Shortcut for layer.shadowRadius
    var shadowRadius: CGFloat {
        get {
            return layer.shadowRadius
        }
        set {
            layer.shadowRadius = newValue
        }
    }
    
    /// Shortcut for layer.shadowOpacity
    var shadowOpacity: Float {
        get {
            return layer.shadowOpacity
        }
        set {
            layer.shadowOpacity = newValue
        }
    }
    
    /// Shortcut for layer.borderWidth
    var borderWidth: CGFloat {
        get {
            return layer.borderWidth
        }
        set {
            layer.borderWidth = newValue
        }
    }
    
    /// Shortcut for layer.borderColor
    var borderColor: UIColor? {
        get {
            return layer.borderColor.flatMap(UIColor.init)
        }
        set {
            layer.borderColor = newValue?.cgColor
        }
    }
}
