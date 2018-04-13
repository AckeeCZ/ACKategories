//
//  UIViewController+Children.swift
//  ACKategories
//
//  Created by Jakub Olejník on 13/04/2018.
//  Copyright © 2018 Josef Dolezal. All rights reserved.
//

import UIKit

extension UIViewController {
    
    /// Display `childViewController` in given `view`.
    ///
    /// If `view` is `nil` (by default) then controller is displayed in `self.view`.
    public func display(childViewController: UIViewController, in view: UIView? = nil) {
        guard let view = view ?? self.view else { return }
        
        view.translatesAutoresizingMaskIntoConstraints = false
        childViewController.view.translatesAutoresizingMaskIntoConstraints = false
        
        childViewController.willMove(toParentViewController: self)
        addChildViewController(childViewController)
        view.addSubview(childViewController.view)
        view.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "|[view]|", options: NSLayoutFormatOptions(rawValue: 0), metrics: nil, views: ["view": childViewController.view]))
        view.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|[view]|", options: NSLayoutFormatOptions(rawValue: 0), metrics: nil, views: ["view": childViewController.view]))
        childViewController.didMove(toParentViewController: self)
    }

    /// Remove child view controller from controller hierarchy, nothing happens if `self` is not `parent` of `childViewController`
    public func remove(childViewController: UIViewController) {
        guard childViewController.parent === self else { return }
        
        childViewController.willMove(toParentViewController: nil)
        childViewController.view.removeFromSuperview()
        childViewController.removeFromParentViewController()
        childViewController.didMove(toParentViewController: nil)
    }
}
