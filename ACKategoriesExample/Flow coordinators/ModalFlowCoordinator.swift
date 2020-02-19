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
        super.start(from: viewController)

        let modalVC = ModalViewController()
        modalVC.flowDelegate = self
        rootViewController = modalVC
        viewController.present(modalVC, animated: true)
    }
}

extension ModalFlowCoordinator: ModalFlowDelegate {
    func didTapDismiss(in viewController: ModalViewController) {
        stop(animated: true)
    }
}
