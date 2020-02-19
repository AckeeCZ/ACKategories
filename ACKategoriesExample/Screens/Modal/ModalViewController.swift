//
//  ModalViewController.swift
//  ACKategories-Example
//
//  Created by Jakub Olejník on 22/10/2019.
//  Copyright © 2019 Ackee, s.r.o. All rights reserved.
//

import UIKit

protocol ModalFlowDelegate: AnyObject {
    func didTapDismiss(in viewController: ModalViewController)
}

final class ModalViewController: BaseViewControllerNoVM {
    weak var flowDelegate: ModalFlowDelegate?

    private weak var button: UIButton!

    // MARK: - View life cycle

    override func loadView() {
        super.loadView()

        let button = UIButton(type: .system)
        button.setTitle("Dismiss", for: .normal)
        view.addSubview(button)
        button.snp.makeConstraints { (make) in
            make.center.equalToSuperview()
        }
        self.button = button
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        button.on { [weak self] _ in
            guard let self = self else { return }
            self.flowDelegate?.didTapDismiss(in: self)
        }
    }
}
