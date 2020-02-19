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
        guard
            let view = view ?? self.view,
            let childView = childViewController.view
        else { return }

        view.translatesAutoresizingMaskIntoConstraints = false
        childViewController.view.translatesAutoresizingMaskIntoConstraints = false

        childViewController.willMove(toParent: self)
        addChild(childViewController)
        view.addSubview(childViewController.view)
        view.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "|[view]|", options: NSLayoutConstraint.FormatOptions(rawValue: 0), metrics: nil, views: ["view": childView]))
        view.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|[view]|", options: NSLayoutConstraint.FormatOptions(rawValue: 0), metrics: nil, views: ["view": childView]))
        childViewController.didMove(toParent: self)
    }

    /// Remove child view controller from controller hierarchy, nothing happens if `self` is not `parent` of `childViewController`
    public func remove(childViewController: UIViewController) {
        guard childViewController.parent === self else { return }

        childViewController.willMove(toParent: nil)
        childViewController.view.removeFromSuperview()
        childViewController.removeFromParent()
        childViewController.didMove(toParent: nil)
    }
}
