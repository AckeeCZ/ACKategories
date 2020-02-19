//
//  VCCompositionViewController.swift
//  ACKategories
//
//  Created by Jakub Olejník on 12/09/2018.
//  Copyright © 2018 Ackee, s.r.o. All rights reserved.
//

import UIKit
import SnapKit

final class VCCompositionViewController: TitleViewController {

    // MARK: Initializers

    init() {
        super.init(name: "Parent", color: .lightGray)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: View life cycle

    override func loadView() {
        super.loadView()

        let containerView = UIView()
        view.addSubview(containerView)
        containerView.snp.makeConstraints { (make) in
            make.leading.trailing.bottom.equalToSuperview()
            make.top.equalTo(nameLabel.snp.bottom).offset(30)
        }

        let childVC = TitleViewController(name: "Child", color: .blue)
        display(childViewController: childVC, in: containerView)
    }
}
