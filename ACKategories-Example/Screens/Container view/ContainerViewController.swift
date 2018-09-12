//
//  ContainerViewController.swift
//  ACKategories
//
//  Created by Jakub Olejník on 12/09/2018.
//  Copyright © 2018 Ackee, s.r.o. All rights reserved.
//

import UIKit
import ACKategories

final class ContainerViewController: UIViewController {

    // MARK: View life cycle

    override func loadView() {
        super.loadView()
        
        view.backgroundColor = .white

        let roundedView = UIView()
        roundedView.backgroundColor = .red
        roundedView.layer.cornerRadius = 30
        roundedView.layer.masksToBounds = true
        roundedView.snp.makeConstraints { (make) in
            make.size.equalTo(60)
        }
        
        let shadowView = ContainerView(view: roundedView)
        shadowView.layer.shadowColor = UIColor.black.cgColor
        shadowView.layer.shadowOpacity = 0.3
        view.addSubview(shadowView)
        shadowView.snp.makeConstraints { (make) in
            make.center.equalToSuperview()
        }
    }
}
