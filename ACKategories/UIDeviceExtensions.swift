//
//  UIDeviceExtensions.swift
//  ACKategories
//
//  Created by Jakub Olejník on 13/04/2018.
//  Copyright © 2018 Josef Dolezal. All rights reserved.
//

import UIKit

extension UIDevice {
    /// Return **true** if device is iPad
    public var isPad: Bool {
        return userInterfaceIdiom == .pad
    }
}
