//
//  ModalFlowCoordinator.swift
//  ACKategories-Example
//
//  Created by Jakub Olejník on 22/10/2019.
//  Copyright © 2019 Ackee, s.r.o. All rights reserved.
//

import UIKit
import ACKategories

final class ModalFlowCoordinator: Base.FlowCoordinatorNoDeepLink {
    override func start(from viewController: UIViewController) {
        let modalVC = ModalViewController()
        modalVC.flowDelegate = self
        rootViewController = modalVC
        
        super.start(from: viewController)
     
        viewController.present(modalVC, animated: true)
    }
}

extension ModalFlowCoordinator: ModalFlowDelegate {
    func didTapDismiss(in viewController: ModalViewController) {
        stop(animated: true)
    }
}
