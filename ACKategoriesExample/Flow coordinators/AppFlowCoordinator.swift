//
//  AppFlowCoordinator.swift
//  ACKategories-Example
//
//  Created by Jakub Olejník on 12/09/2018.
//  Copyright © 2018 Ackee, s.r.o. All rights reserved.
//

import UIKit
import ACKategories

final class AppFlowCoordinator: Base.FlowCoordinatorNoDeepLink {
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
        switch item {
        case .uiControlBlocks:
            let itemVC = UIControlBlocksViewController()
            itemVC.title = item.title
            navigationController?.pushViewController(itemVC, animated: true)
        case .viewControllerComposition:
            let itemVC = VCCompositionViewController()
            itemVC.title = item.title
            navigationController?.pushViewController(itemVC, animated: true)
        case .present:
            let modalFlow = ModalFlowCoordinator()
            addChild(modalFlow)
            modalFlow.start(from: viewController)
         case .mapViewController:
            let mapVC = MapViewController(viewModel: MapViewModel())
            mapVC.title = item.title
            navigationController?.pushViewController(mapVC, animated: true)
        }
    }
}
