//
//  Dummies.swift
//  ACKategories-iOSTests
//
//  Created by Lukáš Hromadník on 23.11.2020.
//

import UIKit
@testable import ACKategories

extension Base.FlowCoordinatorNoDeepLink {
    func push(_ vc: UIViewController) {
        navigationController?.pushViewController(vc, animated: false)
    }
    
    func present(_ vc: UIViewController) {
        rootViewController.present(vc, animated: false)
    }
}

class NavigationFC: Base.FlowCoordinatorNoDeepLink {
    override func start(in window: UIWindow) {
        let rootVC = UIViewController()
        let navVC = UINavigationController(rootViewController: rootVC)
        rootViewController = rootVC
        navigationController = navVC
        
        window.rootViewController = navigationController
        window.makeKeyAndVisible()
        _ = navVC.view
        
        super.start(in: window)
    }
}

class InnerNavigationFC: Base.FlowCoordinatorNoDeepLink {
    override func start(with navigationController: UINavigationController) {
        let controller = UIViewController()
        navigationController.pushViewController(controller, animated: false)

        rootViewController = controller

        super.start(with: navigationController)
    }
}

class PresentFC: Base.FlowCoordinatorNoDeepLink {
    private let completion: () -> Void
    
    init(completion: @escaping () -> Void) {
        self.completion = completion
    }
    
    override func start(from viewController: UIViewController) {
        let rootVC = UIViewController()
        let navVC = UINavigationController(rootViewController: rootVC)
        navVC.modalPresentationStyle = .fullScreen
        viewController.present(navVC, animated: false, completion: completion)
        
        rootViewController = rootVC
        navigationController = navVC

        super.start(from: viewController)
    }
}

