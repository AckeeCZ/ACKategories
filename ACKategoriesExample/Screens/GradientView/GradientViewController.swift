//
//  GradientViewController.swift
//  ACKategoriesExample
//
//  Created by Jan Mísař on 20.01.2021.
//

import UIKit
import ACKategories

class GradientViewController: UIViewController {

    private weak var gradientView: GradientView!
    private weak var button: UIButton!

    override func loadView() {
        super.loadView()

        view.backgroundColor = .white

        let gradientView = GradientView()
        view.addSubview(gradientView)
        gradientView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            gradientView.topAnchor.constraint(equalTo: view.topAnchor),
            gradientView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            gradientView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            gradientView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
        self.gradientView = gradientView

        let button = UIButton(type: .system)
        button.setTitle("Change colors and switch axis", for: .normal)
        button.backgroundColor = .white
        button.titleEdgeInsets = UIEdgeInsets(top: 5, left: 10, bottom: 5, right: 10)
        view.addSubview(button)
        button.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            button.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            button.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
        self.button = button
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        button.on(.touchUpInside) { [unowned self] _ in
            self.gradientView.colors = GradientViewController.randomColors()
            self.gradientView.axis = (self.gradientView.axis == .vertical) ? .horizontal : .vertical
        }
    }

    private static func randomColors() -> [UIColor] {
        let colorsCount = Int.random(in: 2..<5)

        var colors = [UIColor]()
        (0..<colorsCount).forEach { _ in
            colors.append(UIColor.random())
        }
        return colors
    }

}
