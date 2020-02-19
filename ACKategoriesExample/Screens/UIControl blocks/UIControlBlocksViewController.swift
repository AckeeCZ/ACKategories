//
//  UIControlBlocksViewController.swift
//  ACKategories
//
//  Created by Jakub Olejník on 12/09/2018.
//  Copyright © 2018 Ackee, s.r.o. All rights reserved.
//

import UIKit
import ACKategories

final class UIControlBlocksViewController: BaseViewControllerNoVM {

    private weak var button: UIButton!

    // MARK: View life cycle

    override func loadView() {
        super.loadView()

        view.backgroundColor = .white

        let button = UIButton(type: .system)
        button.setTitle("Tap here!", for: .normal)

        if #available(iOS 13.0, *) {
            button.setBackgroundImage(UIColor.systemGray6.image(), for: .normal)
        }

        view.addSubview(button)
        button.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }
        self.button = button
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        button.on(.touchUpInside) { [unowned self] _ in
            let alertVC = UIAlertController(title: "Button", message: "Tapped!", preferredStyle: .alert)
            let okAction = UIAlertAction(title: "OK", style: .default)

            alertVC.addAction(okAction)

            self.present(alertVC, animated: true)
        }
    }
}
