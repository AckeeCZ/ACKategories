//
//  UINavigationController.swift
//  ACKategories-iOSTests
//
//  Created by Lukáš Hromadník on 23.11.2020.
//

import UIKit

extension UINavigationController {
    func popToRootViewController(animated: Bool, completion: @escaping () -> Void) {
        CATransaction.begin()
        CATransaction.setCompletionBlock(completion)
        popToRootViewController(animated: animated)
        CATransaction.commit()
    }
}
