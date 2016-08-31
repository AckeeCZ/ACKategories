//
//  Control.swift
//  Pods
//
//  Created by Jan Mísař on 31.08.16.
//
//

import UIKit

class ActionWrapper<T: UIControl> {
    var action: (T -> Void)

    init(action: (T -> Void)) {
        self.action = action
    }

    @objc func invokeAction(sender: UIControl) {
        if let sender = sender as? T {
            action(sender)
        }
    }
}

public protocol UIControlEventHandling {
    func on(events: UIControlEvents, handler: Self -> Void)
}

private var actionKey: UInt8 = 0

public extension UIControlEventHandling where Self: UIControl {

    public func on(events: UIControlEvents, handler: Self -> Void) {

        var actions: NSMutableArray! = nil

        // remove existing target
        if let target = objc_getAssociatedObject(self, &actionKey) as? ActionWrapper {
            removeTarget(target, action: nil, forControlEvents: .AllEvents)
        }

        let actionWrapper = ActionWrapper(action: handler)

        objc_setAssociatedObject(self, &actionKey, actionWrapper, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)

        addTarget(actionWrapper, action: #selector(ActionWrapper.invokeAction(_:)), forControlEvents: events)
    }
}

extension UIControl: UIControlEventHandling { }
