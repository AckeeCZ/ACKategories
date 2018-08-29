//
//  ViewController.swift
//  ACKategories-Example
//
//  Created by Jakub Olejník on 06/02/2018.
//  Copyright © 2018 Josef Dolezal. All rights reserved.
//

import UIKit
import SnapKit
import ACKategories

final class ViewController: UIViewController {

    private weak var button: UIButton!
    
    override func loadView() {
        super.loadView()
        
        view.backgroundColor = .white
        
        let button = UIButton(type: .system)
        button.setTitle("Tap here!", for: .normal)
        view.addSubview(button)
        button.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }
        self.button = button
        
        let container = UIView()
        view.addSubview(container)
        container.snp.makeConstraints { (make) in
            make.bottom.leading.trailing.equalToSuperview()
            make.height.equalTo(100)
        }
        
        let childVC = UIViewController()
        childVC.view.backgroundColor = .red
        display(childViewController: childVC, in: container)
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

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
