//
//  UIViewExtensions.swift
//  ACKategories
//
//  Created by Jakub Olejník on 14/06/2019.
//  Copyright © 2019 Ackee, s.r.o. All rights reserved.
//

import UIKit

public extension UIView {
    /// Make `self` require its intrinsic size.
    ///
    /// Sets its `contentHuggingPriority` and `contentCompressionResistancePriority` to `UILayoutPriority.required`.
    func forceIntrinsic() {
        setContentHuggingPriority(.required, for: .horizontal)
        setContentHuggingPriority(.required, for: .vertical)
        setContentCompressionResistancePriority(.required, for: .horizontal)
        setContentCompressionResistancePriority(.required, for: .vertical)
    }
}
