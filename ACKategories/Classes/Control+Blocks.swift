//
//  Control.swift
//  Pods
//
//  Created by Jan Mísař on 31.08.16.
//
//

import UIKit

class CollectionWrapper<T: UIControl> {
    var targets: [UIControlEvents.RawValue: ActionWrapper<T>] = [:]
}

class ActionWrapper<T: UIControl> {
    let action: (T -> Void)

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

    /**
     Register action block to be executed on defined events.

     - parameter events Events to fire action block
     - parameter handler Actionblock to be executed
     */
    func on(events: UIControlEvents, handler: Self -> Void) {

        let targetsWrapper: CollectionWrapper<Self>

        if let associatedTargetsWrapper = objc_getAssociatedObject(self, &actionKey) as? CollectionWrapper<Self> {
            targetsWrapper = associatedTargetsWrapper
        } else {
            targetsWrapper = CollectionWrapper()
            objc_setAssociatedObject(self, &actionKey, targetsWrapper, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }

        if let target = targetsWrapper.targets[events.rawValue] {
            removeTarget(target, action: nil, forControlEvents: events)
        }

        let actionWrapper = ActionWrapper(action: handler)
        targetsWrapper.targets[events.rawValue] = actionWrapper
        addTarget(actionWrapper, action: #selector(ActionWrapper.invokeAction(_:)), forControlEvents: events)
    }
}

extension UIControl: UIControlEventHandling { }
