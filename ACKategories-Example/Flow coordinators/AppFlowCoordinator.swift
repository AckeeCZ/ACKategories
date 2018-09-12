//
//  AppFlowCoordinator.swift
//  ACKategories-Example
//
//  Created by Jakub Olejník on 12/09/2018.
//  Copyright © 2018 Ackee, s.r.o. All rights reserved.
//

import UIKit
import ACKategories

final class AppFlowCoordinator: FlowCoordinator {
    override func start(in window: UIWindow) {
        super.start(in: window)
        
        let exampleListVM = ExampleListViewModel()
        let exampleListVC = ExampleListViewController(viewModel: exampleListVM)
        exampleListVC.flowDelegate = self
        
        let navigationController = UINavigationController(rootViewController: exampleListVC)
        window.rootViewController = navigationController
        
        self.rootViewController = navigationController
        self.navigationController = navigationController
    }    
}

extension AppFlowCoordinator: ExampleListFlowDelegate {
    func exampleItemSelected(_ item: ExampleItem, in viewController: ExampleListViewController) {
        let itemVC = controller(for: item)
        itemVC.title = item.title
        navigationController?.pushViewController(itemVC, animated: true)
    }
    
    private func controller(for item: ExampleItem) -> UIViewController {
        switch item {
        case .uiControlBlocks: return UIControlBlocksViewController()
        case .viewControllerComposition: return VCCompositionViewController()
        case .containerView: return ContainerViewController()
        }
    }
}
