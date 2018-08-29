//
//  FlowCoordinator.swift
//  FlowCoordinators
//
//  Created by Jan Misar on 27.07.18.
//  Copyright © 2018 Jan Misar. All rights reserved.
//

import UIKit

/** Handles view controllers connections and flow
 
 Starts with one of `start()` methods and ends with `stop()`.
 
 All start methods are supposed to be overriden and property `rootViewController` must be set in the end of the overriden implementation to avoid memory leaks.
 Don't forget to call super.start().
 */
class FlowCoordinator: NSObject, UINavigationControllerDelegate {

    weak var navigationController: UINavigationController?

    /// First VC of the flow. Must be set when FC starts.
    weak var rootViewController: UIViewController!

    // MARK: - Lifecycle

    /// Just start and return rootViewController. Object calling this method will connect returned view controller to the flow.
    @discardableResult func start() -> UIViewController {
        checkRootViewController()

        return UIViewController()
    }

    /// Start in window. Window's root VC is supposed to be set.
    func start(in window: UIWindow) {
        checkRootViewController()
    }

    /// Start within existing navigation controller.
    func start(with navigationController: UINavigationController) {
        self.navigationController = navigationController
        navigationController.delegate = self

        checkRootViewController()
    }

    /// Start by presenting from given VC. This method must be overriden by subclass.
    func start(from viewController: UIViewController) {
        checkRootViewController()
    }

    /// Clean up. Must be called when FC finished the flow to avoid memory leaks and unexpcted behavior.
    func stop(animated: Bool = false) {

        // stop all children
        childCoordinators.forEach { $0.stop(animated: animated) }

        // dismiss all VCs presented from root or nav
        if rootViewController.presentedViewController != nil {
            rootViewController.dismiss(animated: animated)
        }

        if navigationController?.presentedViewController != nil {
            navigationController?.dismiss(animated: animated)
        }

        // dismiss when root was presented
        if rootViewController.presentingViewController != nil {
            rootViewController.presentingViewController?.dismiss(animated: animated)
        }

        // pop all view controllers when started within navigation controller
        if let index = navigationController?.viewControllers.index(of: rootViewController) {
            let viewControllers = Array(navigationController?.viewControllers[0..<index] ?? [])
            navigationController?.setViewControllers(viewControllers, animated: animated)
        }

        parentCoordinator?.removeChild(self)
    }

    // MARK: - Child coordinators

    weak var parentCoordinator: FlowCoordinator?

    var childCoordinators = [FlowCoordinator]()

    func addChild(_ flowController: FlowCoordinator) {
        if !childCoordinators.contains { $0 === flowController } {
            childCoordinators.append(flowController)
            flowController.parentCoordinator = self
        }
    }

    func removeChild(_ flowController: FlowCoordinator) {
        if let index = childCoordinators.index (where: { $0 === flowController }) {
            childCoordinators.remove(at: index)
        }
    }

    // MARK: - UINavigationControllerDelegate

    func navigationController(_ navigationController: UINavigationController, didShow viewController: UIViewController, animated: Bool) {

        // ensure the view controller is popping
        guard let fromViewController = navigationController.transitionCoordinator?.viewController(forKey: .from),
            !navigationController.viewControllers.contains(fromViewController) else {
                return
        }

        if let firstViewController = rootViewController, fromViewController == firstViewController {
            navigationController.delegate = parentCoordinator
            stop()
        }
    }

    // MARK: - Debug

    static var logEnabled: Bool = true

    override init() {
        super.init()
        if FlowCoordinator.logEnabled {
            NSLog("🔀 👶 \(self)")
        }
    }

    deinit {
        if FlowCoordinator.logEnabled {
            NSLog("🔀 ⚰️ \(self)")
        }
    }

    /// Wait for a second and check whether rootViewController was set
    private func checkRootViewController() {
        DispatchQueue(label: "rootViewController").asyncAfter(deadline: .now() + 1) { [weak self] in
            if self?.rootViewController == nil { assertionFailure("rootViewController is nil") }
        }
    }
}
