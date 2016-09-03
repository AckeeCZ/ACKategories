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
    func off(events: UIControlEvents)
}

private var actionKey: UInt8 = 0

public extension UIControlEventHandling where Self: UIControl {

    /**
     Register action block to be executed on defined events.

     - parameter events: Events to fire action block
     - parameter handler: Actionblock to be executed
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

    /**
     Removes registered action block for defined events.

     off... We are not stupid, drunk and neither high, we know it's really shity name for this method, but we saw it in Tactile and we found it so funny that we had to use it 😄

     - parameter events: Events to fire action block
     */
    func off(events: UIControlEvents) {

        if let targetsWrapper = objc_getAssociatedObject(self, &actionKey) as? CollectionWrapper<Self>, let target = targetsWrapper.targets[events.rawValue] {
            removeTarget(target, action: nil, forControlEvents: events)
            targetsWrapper.targets.removeValueForKey(events.rawValue)
        }
    }
}

extension UIControl: UIControlEventHandling { }
