import UIKit

private final class CollectionWrapper<T: UIControl> {
    var targets: [UIControl.Event.RawValue: ActionWrapper<T>] = [:]
}

private final class ActionWrapper<T: UIControl> {
    let action: ((T) -> Void)

    init(action: @escaping ((T) -> Void)) {
        self.action = action
    }

    @objc func invokeAction(_ sender: UIControl) {
        if let sender = sender as? T {
            action(sender)
        }
    }
}

public protocol UIControlEventHandling { }

private var actionKey: UInt8 = 0

extension UIControl: UIControlEventHandling {}

public extension UIControlEventHandling where Self: UIControl {

    /**
     Register action block to be executed on defined events.
     
     - parameter events: Events to fire action block
     - parameter handler: Actionblock to be executed
     */
    func on(_ events: UIControl.Event, handler: @escaping (Self) -> Void) {

        let targetsWrapper: CollectionWrapper<Self>

        if let associatedTargetsWrapper = objc_getAssociatedObject(self, &actionKey) as? CollectionWrapper<Self> {
            targetsWrapper = associatedTargetsWrapper
        } else {
            targetsWrapper = CollectionWrapper()
            objc_setAssociatedObject(self, &actionKey, targetsWrapper, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }

        if let target = targetsWrapper.targets[events.rawValue] {
            removeTarget(target, action: nil, for: events)
        }

        let actionWrapper = ActionWrapper(action: handler)
        targetsWrapper.targets[events.rawValue] = actionWrapper
        addTarget(actionWrapper, action: #selector(ActionWrapper.invokeAction(_:)), for: events)
    }

    /**
     Register action block to be executed on primary action.
     
     - parameter handler: Actionblock to be executed
     */
    @available(iOS 9.0, *)
    func on(handler: @escaping (Self) -> Void) {
        on(.primaryActionTriggered, handler: handler)
    }

    /**
     Removes registered action block for defined events.
     
     off... We are not stupid, drunk and neither high, we know it's really shity name for this method, but we saw it in Tactile and we found it so funny that we had to use it 😄
     
     - parameter events: Events to fire action block
     */
    func off(_ events: UIControl.Event) {
        if let targetsWrapper = objc_getAssociatedObject(self, &actionKey) as? CollectionWrapper<Self>, let target = targetsWrapper.targets[events.rawValue] {
            removeTarget(target, action: nil, for: events)
            targetsWrapper.targets.removeValue(forKey: events.rawValue)
        }
    }

}
